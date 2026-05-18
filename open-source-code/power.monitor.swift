import Foundation
import IOKit.ps

final class PowerMonitor {
    static let shared = PowerMonitor()

    private let pollingInterval: TimeInterval = 30
    private var timer: Timer?
    private var autoStoppedOnBattery = false

    private init() {}

    func isCurrentlyOnBattery() -> Bool {
        guard let source = IOPSGetProvidingPowerSourceType(nil)?.takeUnretainedValue() as String? else {
            return false
        }
        return source == kIOPSBatteryPowerValue
    }

    func startMonitoring() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: pollingInterval, repeats: true) { _ in
            self.checkPowerStatus()
        }
    }

    func checkPowerStatus() {
        guard UserDefaults.standard.bool(forKey: "pauseOnBattery") else { return }
        if isCurrentlyOnBattery() {
            if !autoStoppedOnBattery {
                VideoWallpaperManager.shared.stopCurrentWallpaper()
                autoStoppedOnBattery = true
            }
        } else if UserDefaults.standard.bool(forKey: "restoreLastWallpapers") {
            if autoStoppedOnBattery {
                WallpaperRestorer.restore()
                autoStoppedOnBattery = false
            }
        }
    }
}
