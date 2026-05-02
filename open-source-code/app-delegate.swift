import Cocoa
import SwiftUI
import UserNotifications
import Combine

@MainActor
class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    let licenseManager = LicenseManager()

    let videoLibrary = VideoLibraryStore()
    let filterStore  = VideoFilterStore()
    let ui           = WallperUI()
    let deviceLoader = DeviceLoader()

    private var screenChangeObserver: Any?
    private var knownScreenIDs: Set<String> = []

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.appearance = NSAppearance(named: .darkAqua)
        NSApp.setActivationPolicy(.accessory)

        setupNotificationsPermission()
        setupPowerMonitor()

        let boot = LaunchBootstrapper.shared
        boot.start(licenseManager: licenseManager)

        boot.$isAppReady
            .receive(on: RunLoop.main)
            .sink { [weak self] ready in
                guard let self, ready else { return }

                self.licenseManager.startCheckIfNeeded()
                self.installObserversForSpacesAndScreens()
                self.tryRestoreWallpapersIfNeeded()

                WindowManager.shared.setupStatusBarMenu()
                WindowManager.shared.setCanOpenUI(false)

                Task { @MainActor in
                    await self.videoLibrary.loadAll()
                    self.videoLibrary.loadCachedVideos()
                    await self.filterStore.fetchDynamicFilters()
                    if !self.deviceLoader.isLoaded { self.deviceLoader.loadAllDevices() }

                    WindowManager.shared.setCanOpenUI(true)
                    WindowManager.shared.launchMainWindow(
                        licenseManager: self.licenseManager,
                        videoLibrary:   self.videoLibrary,
                        filterStore:    self.filterStore,
                        ui:             self.ui,
                        deviceLoader:   self.deviceLoader
                    )
                }
            }
            .store(in: &WindowManager.shared.cancellables)
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !WindowManager.shared.isUIReady {
            NSSound.beep()
            return true
        }
        WindowManager.shared.restoreFromDockClick()
        return true
    }

    // MARK: - Helpers

    func tryRestoreWallpapersIfNeeded() {
        guard UserDefaults.standard.bool(forKey: "restoreLastWallpapers") else { return }
        if UserDefaults.standard.bool(forKey: "pauseOnBattery"),
           PowerMonitor.shared.isCurrentlyOnBattery() {
            return
        }

        WallpaperRestorer.restore()
        knownScreenIDs = Set(NSScreen.screens.map { $0.deviceIdentifier })
    }

    func handleScreenChanges() {
        WallpaperRestorer.restore()
    }

    func applicationWillTerminate(_ notification: Notification) {
        if let observer = screenChangeObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    private func setupNotificationsPermission() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("🔴 Notification permission error: \(error.localizedDescription)")
            } else {
                print("✅ Notification permission granted: \(granted)")
            }
        }
    }

    private func setupPowerMonitor() {
        if UserDefaults.standard.bool(forKey: "pauseOnBattery") {
            PowerMonitor.shared.startMonitoring()
            PowerMonitor.shared.checkPowerStatus()
        }
    }

    private func installObserversForSpacesAndScreens() {
        NotificationCenter.default.addObserver(
            forName: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            VideoWallpaperManager.shared.reapplyAdaptedWallpapers()
        }

        screenChangeObserver = NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.handleScreenChanges()
        }
    }
}
