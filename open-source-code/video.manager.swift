import AppKit
import AVKit
import AVFoundation
import UserNotifications

/// Manages playing looping video wallpapers across one or multiple macOS displays.
///
/// - Note: Windows are placed just below the desktop window level (desktop-1) and
///   ignore mouse events to remain non-interactive. The manager also supports
///   a menu-bar adaptation mode that sets a still frame as the desktop image
///   to let macOS tint the menu bar appropriately.
class VideoWallpaperManager: NSObject {
    /// Shared singleton instance for global access.
    static let shared = VideoWallpaperManager()

    // MARK: - Internal State (Players/Windows)

    /// Active queue players keyed by screen device identifier.
    private var players: [String: AVQueuePlayer] = [:]

    /// Wallpaper NSWindows keyed by screen device identifier.
    private var windows: [String: NSWindow] = [:]

    /// Loopers that repeat the current `AVPlayerItem` seamlessly.
    private var loopers: [String: AVPlayerLooper] = [:]

    /// Last applied video URL per screen device identifier.
    public var appliedWallpaperURL: [String: URL] = [:]

    // MARK: - Init / Settings Observation

    private override init() {
        super.init()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userDefaultsDidChange),
            name: UserDefaults.didChangeNotification,
            object: nil
        )
    }

    /// Reacts to changes in `UserDefaults` relevant to wallpaper behavior.
    ///
    /// Keys:
    /// - `advancedWallpaperApply`: enables system saver install mode.
    /// - `adaptMenuBar`: captures a still frame to let macOS adapt the menu bar.
    @objc private func userDefaultsDidChange() {
        let advanced = UserDefaults.standard.bool(forKey: "advancedWallpaperApply")
        let adapt = UserDefaults.standard.bool(forKey: "adaptMenuBar")
        print("🔄 Settings changed → advanced: \(advanced), adaptMenuBar: \(adapt)")
    }

    /// Whether the advanced (system-level screensaver) apply mode is enabled.
    private var isAdvancedWallpaperApply: Bool {
        UserDefaults.standard.bool(forKey: "advancedWallpaperApply")
    }

    /// Whether menu bar adaptation via still desktop image is enabled.
    private var adaptMenuBar: Bool {
        UserDefaults.standard.bool(forKey: "adaptMenuBar")
    }

    // MARK: - Public API (Applying / Restoring)

    /// Installs/updates the video as a system screen saver when advanced mode is enabled.
    ///
    /// - Parameter url: A file URL to the video to be installed as a screen saver source.
    /// - Important: No-op if `advancedWallpaperApply` is disabled.
    func setWithAdvancedMode(from url: URL) {
        if isAdvancedWallpaperApply {
            setAsSystemScreenSaver(from: url)
        } else { return }
    }

    /// Applies a looping video wallpaper to one or all connected displays.
    ///
    /// The method creates an invisible borderless window per target screen, places
    /// an `AVPlayerLayer` inside, and loops the provided video using `AVPlayerLooper`.
    /// Optionally also sets a still desktop image to allow menu bar color adaptation.
    ///
    /// - Parameters:
    ///   - url: Local file URL of the video to play.
    ///   - screenIndex: Target screen index (from `NSScreen.screens`), or `nil`.
    ///   - applyToAll: If `true`, applies to all displays. If `false`, only to `screenIndex`.
    ///   - muteSecondaryScreens: If `true`, secondary screens are muted (primary is muted too by design).
    /// - Note: Calling this re-creates player/windows for the target displays and posts `.wallpaperChanged`.
    // MARK: main func
    func setVideoAsWallpaper(
        from url: URL,
        screenIndex: Int?,
        applyToAll: Bool = true,
        muteSecondaryScreens: Bool = true
    ) {

        print(isAdvancedWallpaperApply)

        stopCurrentWallpaper(screenIndex: screenIndex)

        let screens = NSScreen.screens

        for (index, screen) in screens.enumerated() {

            if (isAdvancedWallpaperApply != true) {
                if UserDefaults.standard.bool(forKey: "adaptMenuBar") {
                    self.setDesktopStillFrame(from: url, for: screen)
                }
            }

            if !applyToAll, index != screenIndex { continue }

            let screenID = screen.deviceIdentifier
            let frame = screen.frame

            let window = NSWindow(
                contentRect: CGRect(origin: .zero, size: frame.size),
                styleMask: .borderless,
                backing: .buffered,
                defer: false,
                screen: screen
            )
            window.setFrame(frame, display: true)
            window.level = NSWindow.Level(Int(CGWindowLevelForKey(.desktopWindow)) - 1)
            window.ignoresMouseEvents = true
            window.isOpaque = true
            window.backgroundColor = .black
            window.hasShadow = false
            window.collectionBehavior = [
                .canJoinAllSpaces, .stationary, .fullScreenAuxiliary, .ignoresCycle
            ]

            let contentView = NSView(frame: frame)
            contentView.wantsLayer = true
            window.contentView = contentView

            let item = AVPlayerItem(url: url)
            item.preferredForwardBufferDuration = 0

            let player = AVQueuePlayer()
            player.isMuted = true
            player.automaticallyWaitsToMinimizeStalling = false
            let looper = AVPlayerLooper(player: player, templateItem: item)

            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = frame
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            playerLayer.needsDisplayOnBoundsChange = true

            contentView.layer = playerLayer

            players[screenID] = player
            loopers[screenID] = looper
            windows[screenID] = window

            appliedWallpaperURL[screenID] = url
            NotificationCenter.default.post(name: .wallpaperChanged, object: screenID)
            self.saveAppliedWallpaper(url: url, screenIndex: index)

            window.orderFrontRegardless()

            window.alphaValue = 1

            if let contentView = window.contentView {
                animateReveal(fromCenter: CGPoint(x: frame.width / 2, y: frame.height / 2), in: contentView)
            }

            contentView.layoutSubtreeIfNeeded()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.updateLayerTransform(for: screenID)
                player.play()
                NotificationCenter.default.post(name: .wallpaperChanged, object: screenID)
            }

        }
    }

    /// Restores the last applied wallpapers (per screen) from `UserDefaults`.
    ///
    /// - Note: Expects an array stored under `LastAppliedWallpapers` where each element
    ///   includes `screenIndex`, `url`, and `appliedAt`. Missing screens are skipped.
    func restoreLastWallpapers() {
        let key = "LastAppliedWallpapers"
        guard let saved = UserDefaults.standard.array(forKey: key) as? [[String: Any]] else { return }

        for entry in saved {
            guard
                let screenIndex = entry["screenIndex"] as? Int,
                let urlString = entry["url"] as? String,
                let url = URL(string: urlString),
                NSScreen.screens.indices.contains(screenIndex)
            else { continue }

            setVideoAsWallpaper(from: url, screenIndex: screenIndex, applyToAll: false)
        }
    }

    /// Stops current wallpaper playback.
    ///
    /// - Parameter screenIndex: If provided, stops only that screen's wallpaper.
    ///   If `nil`, stops all wallpapers and tears down related resources.
    // MARK: stop wallpaper
    func stopCurrentWallpaper(screenIndex: Int? = nil) {
        if let index = screenIndex, NSScreen.screens.indices.contains(index) {
            let screen = NSScreen.screens[index]
            let screenID = screen.deviceIdentifier

            players[screenID]?.pause()
            windows[screenID]?.orderOut(nil)

            players.removeValue(forKey: screenID)
            windows.removeValue(forKey: screenID)
            loopers.removeValue(forKey: screenID)
        } else {
            players.values.forEach { $0.pause() }
            windows.values.forEach { $0.orderOut(nil) }

            players.removeAll()
            windows.removeAll()
            loopers.removeAll()
        }
    }

    // MARK: - Public API (Layer Access / Transforms)

    /// Returns the active `AVPlayerLayer` for a given screen device identifier, if any.
    ///
    /// - Parameter screenID: The `NSScreen.deviceIdentifier`.
    /// - Returns: The associated `AVPlayerLayer` or `nil` if unavailable.
    // MARK: layer for wallpaper
    func getPlayerLayer(for screenID: String) -> AVPlayerLayer? {
        guard let window = windows[screenID],
              let layer = window.contentView?.layer as? AVPlayerLayer else {
            return nil
        }
        return layer
    }

    /// Applies pan/zoom transform to a screen’s player layer using stored display settings.
    ///
    /// - Parameter screenID: The `NSScreen.deviceIdentifier`.
    /// - Important: Uses `DisplaySettingsStorage.load(for:)` and performs a short animated update.
    // MARK: transform wallpaper
    func updateLayerTransform(for screenID: String) {
        guard let layer = getPlayerLayer(for: screenID) else { return }
        let config = DisplaySettingsStorage.load(for: screenID) ?? DisplayConfig()
        let frame = layer.bounds

        let centerX = frame.width / 2
        let centerY = frame.height / 2

        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, centerX + config.offset.width, centerY + config.offset.height, 0)
        transform = CATransform3DScale(transform, config.scale, config.scale, 1)
        transform = CATransform3DTranslate(transform, -centerX, -centerY, 0)

        CATransaction.begin()
        CATransaction.setAnimationDuration(0.2)
        layer.transform = transform
        CATransaction.commit()
    }

    // MARK: - Public API (Menu Bar Adaptation)

    /// Reapplies previously adapted desktop images used for menu bar tinting.
    ///
    /// - Note: This re-sets the stored still images as desktop wallpapers per screen.
    public func reapplyAdaptedWallpapers() {
        for screen in NSScreen.screens {
            let screenID = screen.deviceIdentifier
            guard let url = adaptedWallpaperURLs[screenID] else {
                continue
            }

            let options = NSWorkspace.shared.desktopImageOptions(for: screen) ?? [:]

            do {
                try NSWorkspace.shared.setDesktopImageURL(url, for: screen, options: options)
                print("[VM]: 🔁 Reapplied adapted wallpaper on screen \(screenID)")
            } catch {
                print("[VM]: ❌ Failed to reapply wallpaper on screen \(screenID): \(error)")
            }
        }
    }

    // MARK: - Private (Advanced Mode / Menu Bar Helpers)

    /// Installs or updates the system screen saver using the given video URL.
    ///
    /// - Parameter url: Local video file URL.
    private func setAsSystemScreenSaver(from url: URL) {
        ScreensaverManager.shared.installOrUpdateSaver(with: url)
    }
    
    

    /// Captures a still frame from the video and sets it as the desktop image for the specified screen.
    ///
    /// - Parameters:
    ///   - videoURL: Source video URL.
    ///   - screen: Target `NSScreen`.
    /// - Important: Triggers a menu bar redraw shortly after to force color adaptation.
    private var adaptedWallpaperURLs: [String: URL] = [:]
    private func setDesktopStillFrame(from videoURL: URL, for screen: NSScreen) {
        let screenID = screen.deviceIdentifier

        let tmpURL: URL
        do {
            tmpURL = try generateStillImage(from: videoURL)
        } catch {
            print("[VM]: Failed to generate still image: \(error)")
            return
        }

        let options = NSWorkspace.shared.desktopImageOptions(for: screen) ?? [:]

        do {
            try NSWorkspace.shared.setDesktopImageURL(tmpURL, for: screen, options: options)
            print("[VM]: Set menuBarAdapt wallpaper for screen: \(screenID)")
            adaptedWallpaperURLs[screenID] = tmpURL
        } catch {
            print("[VM]: Failed to set wallpaper: \(error)")
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.forceRedrawMenuBar(for: screen, options: options)
        }
    }

    /// Generates a temporary JPEG still image from the given video near the 2s mark.
    ///
    /// - Parameter videoURL: Source video URL.
    /// - Returns: Temporary file URL of the generated JPEG.
    /// - Throws: An error if frame extraction or encoding fails.
    private func generateStillImage(from videoURL: URL) throws -> URL {
        let asset = AVAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = CGSize(width: 1920, height: 1080)

        let time = CMTime(seconds: 2.0, preferredTimescale: 600)
        let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
        let nsImage = NSImage(cgImage: cgImage, size: .zero)

        guard let tiffData = nsImage.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiffData),
              let jpegData = bitmap.representation(using: .jpeg, properties: [:]) else {
            throw NSError(domain: "ImageEncoding", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode image"])
        }

        let filename = "menuBarAdapt-\(UUID().uuidString).jpg"
        let tmpURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        try jpegData.write(to: tmpURL)
        return tmpURL
    }

    /// Forces macOS to reapply the current desktop image on a screen to trigger menu bar redraw.
    ///
    /// - Parameters:
    ///   - screen: Target `NSScreen`.
    ///   - options: Options used with `NSWorkspace.shared.setDesktopImageURL`.
    private func forceRedrawMenuBar(for screen: NSScreen, options: [NSWorkspace.DesktopImageOptionKey: Any]) {
        do {
            if let currentURL = try NSWorkspace.shared.desktopImageURL(for: screen) {
                try NSWorkspace.shared.setDesktopImageURL(currentURL, for: screen, options: options)
                print("[VM]: Forced menu bar redraw on screen: \(screen.deviceIdentifier)")
            } else {
                print("[VM]: ⚠️ No current desktop image URL for screen: \(screen.deviceIdentifier)")
            }
        } catch {
            print("[VM]: ❌ Failed to force-refresh menu bar wallpaper: \(error)")
        }
    }

    /// Persists the last applied wallpaper per screen index in `UserDefaults`.
    ///
    /// - Parameters:
    ///   - url: Video file URL that was applied.
    ///   - screenIndex: Index from `NSScreen.screens`.
    // MARK: save to user def last wallpapers
    private func saveAppliedWallpaper(url: URL, screenIndex: Int) {
        let key = "LastAppliedWallpapers"
        var current = UserDefaults.standard.array(forKey: key) as? [[String: Any]] ?? []

        let entry: [String: Any] = [
            "screenIndex": screenIndex,
            "url": url.absoluteString,
            "appliedAt": Date().timeIntervalSince1970
        ]

        current.removeAll { $0["screenIndex"] as? Int == screenIndex }
        current.append(entry)

        UserDefaults.standard.set(current, forKey: key)
    }

    /// Circular reveal animation for the initial wallpaper appearance.
    ///
    /// - Parameters:
    ///   - center: The center point of the reveal circle.
    ///   - view: The host view to mask and animate.
    private func animateReveal(fromCenter center: CGPoint, in view: NSView) {
        let startPath = NSBezierPath(ovalIn: CGRect(origin: center, size: .zero))
        let maxDimension = max(view.bounds.width, view.bounds.height) * 1.5
        let endPath = NSBezierPath(ovalIn: CGRect(
            x: center.x - maxDimension,
            y: center.y - maxDimension,
            width: maxDimension * 2,
            height: maxDimension * 2
        ))

        let maskLayer = CAShapeLayer()
        maskLayer.path = endPath.cgPath
        view.layer?.mask = maskLayer

        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = 0.6
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        maskLayer.add(animation, forKey: "reveal")
        maskLayer.path = endPath.cgPath

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            view.layer?.mask = nil
        }
    }

    // MARK: - KVO (Player Item Status)

    /// Observes `AVPlayerItem.status` to log readiness or failure states.
    ///
    /// - Parameters:
    ///   - keyPath: Observed key path (expects `"status"`).
    ///   - object: The observed `AVPlayerItem`.
    ///   - change: KVO change dictionary.
    ///   - context: Optional context pointer.
    /// - Important: Removes the observer once a terminal status is reached.
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "status",
           let item = object as? AVPlayerItem {
            switch item.status {
            case .readyToPlay:
                print("AVPlayerItem ready to play")
            case .failed:
                print("AVPlayerItem failed: \(String(describing: item.error))")
            default:
                break
            }
            item.removeObserver(self, forKeyPath: "status")
        }
    }
}

// MARK: - Helpers / Extensions

extension NSScreen {
    /// Stable-ish numeric identifier for the screen, falling back to a UUID string if unavailable.
    var deviceIdentifier: String {
        if let screenNumber = deviceDescription[.init("NSScreenNumber")] as? NSNumber {
            return screenNumber.stringValue
        }
        return UUID().uuidString
    }
}

extension NSBezierPath {
    /// Converts `NSBezierPath` to Core Graphics path.
    var cgPath: CGPath {
        let path = CGMutablePath()
        let points = UnsafeMutablePointer<NSPoint>.allocate(capacity: 3)
        for i in 0..<elementCount {
            let type = element(at: i, associatedPoints: points)
            switch type {
            case .moveTo: path.move(to: points[0])
            case .lineTo: path.addLine(to: points[0])
            case .curveTo: path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath: path.closeSubpath()
            @unknown default: break
            }
        }
        points.deallocate()
        return path
    }
}

extension Notification.Name {
    /// Posted when a wallpaper has been (re)applied for a given screen (object = screenID `String`).
    static let wallpaperChanged = Notification.Name("VideoWallpaperManager.wallpaperChanged")
}
