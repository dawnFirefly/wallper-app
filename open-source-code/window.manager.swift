import Foundation
import AppKit
import SwiftUI
import Combine
import UniformTypeIdentifiers

final class WindowManager: NSObject {
    static let shared = WindowManager()

    var cancellables = Set<AnyCancellable>()
    private(set) var isUIReady = false

    private var statusItem: NSStatusItem?
    private var mainWindow: NSWindow?

    private(set) weak var licenseManager: LicenseManager?
    private(set) weak var videoLibrary: VideoLibraryStore?
    private(set) weak var filterStore: VideoFilterStore?
    private(set) weak var wallperUI: WallperUI?
    private(set) weak var deviceLoader: DeviceLoader?

    private override init() {}

    func setupStatusBarMenu() {
        if statusItem == nil {
            statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        }
        statusItem?.button?.title = "🖼"

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Open Wallper", action: #selector(openApp), keyEquivalent: "o"))
        menu.addItem(NSMenuItem(title: "Import Video…", action: #selector(importVideo), keyEquivalent: "i"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Stop Wallpaper", action: #selector(stopWallpaper), keyEquivalent: "s"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        menu.items.forEach { $0.target = self }
        statusItem?.menu = menu
    }

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
        self.licenseManager = licenseManager
        self.videoLibrary = videoLibrary
        self.filterStore = filterStore
        self.wallperUI = ui
        self.deviceLoader = deviceLoader

        let contentView = ui.makeRootView(
            licenseManager: licenseManager,
            videoLibrary: videoLibrary,
            filterStore: filterStore,
            deviceLoader: deviceLoader
        )

        if mainWindow == nil {
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 760, height: 560),
                styleMask: [.titled, .closable, .miniaturizable, .resizable],
                backing: .buffered,
                defer: false
            )
            window.center()
            window.title = "Wallper"
            window.isReleasedWhenClosed = false
            mainWindow = window
        }

        mainWindow?.contentView = NSHostingView(rootView: contentView)
        mainWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        isUIReady = true
    }

    func restoreFromDockClick() {
        if let mainWindow {
            mainWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
        }
    }

    func importVideoIntoLibrary(_ library: VideoLibraryStore) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedContentTypes = [.movie]

        if panel.runModal() == .OK, let url = panel.url {
            _ = library.importVideo(from: url)
        }
    }

    @objc private func openApp() {
        guard isUIReady else {
            NSSound.beep()
            return
        }
        restoreFromDockClick()
    }

    @objc private func importVideo() {
        guard let videoLibrary else { return }
        importVideoIntoLibrary(videoLibrary)
    }

    @objc private func stopWallpaper() {
        VideoWallpaperManager.shared.stopCurrentWallpaper()
    }

    @objc private func quitApp() {
        NSApp.terminate(nil)
    }
}
