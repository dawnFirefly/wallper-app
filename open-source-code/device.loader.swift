import Foundation
import AppKit
import IOKit
import Combine

enum HWIDProvider {
    private static let fallbackKey = "wallper.fallback.hwid"

    static func getHWID() -> String {
        let service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        defer {
            if service != 0 {
                IOObjectRelease(service)
            }
        }

        guard service != 0,
              let cfUUID = IORegistryEntryCreateCFProperty(
                service,
                "IOPlatformUUID" as CFString,
                kCFAllocatorDefault,
                0
              )?.takeRetainedValue(),
              let uuid = cfUUID as? String,
              !uuid.isEmpty else {
            if let persisted = UserDefaults.standard.string(forKey: fallbackKey), !persisted.isEmpty {
                return persisted
            }
            let generated = UUID().uuidString
            UserDefaults.standard.set(generated, forKey: fallbackKey)
            return generated
        }

        return uuid
    }
}

final class DeviceLoader: ObservableObject {
    @Published private(set) var isLoaded = false
    @Published private(set) var snapshot: DeviceSnapshot?

    func loadAllDevices() {
        let screens = NSScreen.screens.enumerated().map { index, screen in
            ScreenSnapshot(
                id: stableScreenID(for: screen),
                width: Int(screen.frame.width),
                height: Int(screen.frame.height),
                scale: screen.backingScaleFactor,
                isPrimary: index == 0
            )
        }

        snapshot = DeviceSnapshot(
            hwid: HWIDProvider.getHWID(),
            hostName: Host.current().localizedName ?? "macOS",
            osVersion: ProcessInfo.processInfo.operatingSystemVersionString,
            screens: screens,
            capturedAt: Date()
        )
        isLoaded = true
    }
}

func logDeviceToLambda() {
    let screens = NSScreen.screens.enumerated().map { index, screen in
        ScreenSnapshot(
            id: stableScreenID(for: screen),
            width: Int(screen.frame.width),
            height: Int(screen.frame.height),
            scale: screen.backingScaleFactor,
            isPrimary: index == 0
        )
    }
    let snapshot = DeviceSnapshot(
        hwid: HWIDProvider.getHWID(),
        hostName: Host.current().localizedName ?? "macOS",
        osVersion: ProcessInfo.processInfo.operatingSystemVersionString,
        screens: screens,
        capturedAt: Date()
    )
    try? FileManager.default.createDirectory(at: AppPaths.logDirectory, withIntermediateDirectories: true)
    let fileURL = AppPaths.logDirectory.appendingPathComponent("device.log")
    let line = "[\(ISO8601DateFormatter().string(from: Date()))] \(snapshot.hwid) \(snapshot.osVersion)\n"
    if FileManager.default.fileExists(atPath: fileURL.path),
       let handle = try? FileHandle(forWritingTo: fileURL) {
        handle.seekToEndOfFile()
        handle.write(Data(line.utf8))
        try? handle.close()
    } else {
        try? Data(line.utf8).write(to: fileURL, options: .atomic)
    }
}

private func stableScreenID(for screen: NSScreen) -> String {
    if let screenNumber = screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] as? NSNumber {
        return screenNumber.stringValue
    }
    return "\(Int(screen.frame.width))x\(Int(screen.frame.height))-\(Int(screen.frame.origin.x))-\(Int(screen.frame.origin.y))"
}
