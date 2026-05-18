import Foundation

final class ScreensaverManager {
    static let shared = ScreensaverManager()

    private let saverDir = AppPaths.supportDirectory.appendingPathComponent("Screensaver", isDirectory: true)

    private init() {
        try? FileManager.default.createDirectory(at: saverDir, withIntermediateDirectories: true)
    }

    func installOrUpdateSaver(with url: URL) {
        let ext = url.pathExtension.lowercased()
        guard ["mp4", "mov", "m4v", "avi", "mkv"].contains(ext) else {
            print("[Screensaver] Unsupported video extension: \(url.pathExtension)")
            return
        }
        let target = saverDir.appendingPathComponent("active.\(ext)")

        do {
            if FileManager.default.fileExists(atPath: target.path) {
                try FileManager.default.removeItem(at: target)
            }
            try FileManager.default.copyItem(at: url, to: target)
        } catch {
            print("[Screensaver] Failed to stage file: \(error)")
        }
    }
}
