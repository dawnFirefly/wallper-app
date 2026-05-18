import Foundation
import AppKit
import IOKit
import Combine

enum HWIDProvider {
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
            return UUID().uuidString
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
                id: screen.deviceIdentifier,
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
            id: screen.deviceIdentifier,
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
