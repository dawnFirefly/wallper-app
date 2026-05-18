import Foundation
import IOKit.ps

final class PowerMonitor {
    static let shared = PowerMonitor()

    private var timer: Timer?

    private init() {}

    func isCurrentlyOnBattery() -> Bool {
        guard let source = IOPSGetProvidingPowerSourceType(nil)?.takeRetainedValue() as String? else {
            return false
        }
        return source == kIOPSBatteryPowerValue
    }

    func startMonitoring() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.checkPowerStatus()
        }
    }

    func checkPowerStatus() {
        guard UserDefaults.standard.bool(forKey: "pauseOnBattery") else { return }
        if isCurrentlyOnBattery() {
            VideoWallpaperManager.shared.stopCurrentWallpaper()
        } else if UserDefaults.standard.bool(forKey: "restoreLastWallpapers") {
            WallpaperRestorer.restore()
        }
    }
}
