import Foundation
import Combine
import AppKit
import CoreGraphics

final class LicenseManager: ObservableObject {
    @Published private(set) var isChecked = false

    func checkFirstSeen(for hwid: String) {}

    func checkLicense(for hwid: String) {
        isChecked = true
    }
}

final class VideoLibraryStore: ObservableObject {
    func loadAll() async {}
    func loadCachedVideos() {}
}

final class VideoFilterStore: ObservableObject {
    func fetchDynamicFilters() async {}
}

final class DeviceLoader: ObservableObject {
    private(set) var isLoaded = false

    func loadAllDevices() {
        isLoaded = true
    }
}

final class WallperUI: ObservableObject {}

final class WindowManager {
    static let shared = WindowManager()

    var cancellables = Set<AnyCancellable>()
    private(set) var isUIReady = false

    private init() {}

    func setupStatusBarMenu() {}

    func setCanOpenUI(_ ready: Bool) {
        isUIReady = ready
    }

    func launchMainWindow(
        licenseManager: LicenseManager,
        videoLibrary: VideoLibraryStore,
        filterStore: VideoFilterStore,
        ui: WallperUI,
        deviceLoader: DeviceLoader
    ) {
        isUIReady = true
    }

    func restoreFromDockClick() {}
}

final class PowerMonitor {
    static let shared = PowerMonitor()

    private init() {}

    func isCurrentlyOnBattery() -> Bool { false }
    func startMonitoring() {}
    func checkPowerStatus() {}
}

enum WallpaperRestorer {
    static func restore() {
        VideoWallpaperManager.shared.restoreLastWallpapers()
    }
}

struct UpdateInfo {
    let version: String
}

final class UpdateManager: ObservableObject {
    static let shared = UpdateManager()

    @Published private(set) var didFinishCheck = false
    @Published private(set) var isUpdateAvailable = false
    private(set) var updateInfo: UpdateInfo?

    private init() {}

    func checkForUpdate() {
        didFinishCheck = true
        isUpdateAvailable = false
        updateInfo = nil
    }

    func startUpdate() {}
}

final class BanChecker {
    func checkBanStatus(completion: @escaping (Bool) -> Void) {
        completion(false)
    }
}

enum HWIDProvider {
    static func getHWID() -> String {
        Host.current().localizedName ?? UUID().uuidString
    }
}

final class Env {
    static let shared = Env()

    private init() {}

    func loadSyncFromLambda() {}
}

func logDeviceToLambda() {}

final class ScreensaverManager {
    static let shared = ScreensaverManager()

    private init() {}

    func installOrUpdateSaver(with url: URL) {}
}

struct DisplayConfig {
    var scale: CGFloat = 1.0
    var offset: CGSize = .zero
}

enum DisplaySettingsStorage {
    static func load(for screenID: String) -> DisplayConfig? {
        nil
    }
}
