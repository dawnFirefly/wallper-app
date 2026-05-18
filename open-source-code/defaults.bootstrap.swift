import Foundation

enum DefaultsBootstrap {
    static func apply() {
        UserDefaults.standard.register(defaults: [
            "restoreLastWallpapers": true,
            "pauseOnBattery": false,
            "adaptMenuBar": true,
            "advancedWallpaperApply": false
        ])
    }
}
