import Foundation

enum AppPaths {
    static let supportDirectory: URL = {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let dir = base.appendingPathComponent("Wallper", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    static let libraryDirectory: URL = {
        let dir = supportDirectory.appendingPathComponent("Library", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }()

    static let libraryIndexFile = supportDirectory.appendingPathComponent("library.json")
    static let licenseFile = supportDirectory.appendingPathComponent("license.json")
    static let envFile = supportDirectory.appendingPathComponent("env.json")
    static let updateFeedFile = supportDirectory.appendingPathComponent("updates.json")
    static let logDirectory = supportDirectory.appendingPathComponent("Logs", isDirectory: true)
}
