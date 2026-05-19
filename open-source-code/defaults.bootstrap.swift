import Foundation

enum DefaultsBootstrap {
    static let menuBarAdaptationKey = "enableMenuBarAdaptation"
    private static let legacyMenuBarAdaptationKey = "adaptMenuBar"

    static func apply() {
        migrateLegacyKeysIfNeeded()
        UserDefaults.standard.register(defaults: [
            "restoreLastWallpapers": true,
            "pauseOnBattery": false,
            menuBarAdaptationKey: true,
            "advancedWallpaperApply": false
        ])
    }

    private static func migrateLegacyKeysIfNeeded() {
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: menuBarAdaptationKey) == nil,
              defaults.object(forKey: legacyMenuBarAdaptationKey) != nil else { return }
        defaults.set(defaults.bool(forKey: legacyMenuBarAdaptationKey), forKey: menuBarAdaptationKey)
    }
}
