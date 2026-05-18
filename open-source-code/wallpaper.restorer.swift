import Foundation

enum WallpaperRestorer {
    static func restore() {
        VideoWallpaperManager.shared.restoreLastWallpapers()
    }
}
