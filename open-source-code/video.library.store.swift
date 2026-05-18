import Foundation
import AVFoundation
import Combine

final class VideoLibraryStore: ObservableObject {
    private static let invalidDuration: TimeInterval = -1

    @Published private(set) var videos: [VideoAsset] = []
    @Published private(set) var lastError: String?

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init() {
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            try FileManager.default.createDirectory(at: AppPaths.libraryDirectory, withIntermediateDirectories: true)
        } catch {
            lastError = "Failed to create library directory: \(error.localizedDescription)"
        }
    }

    func loadAll() async {
        guard let data = try? Data(contentsOf: AppPaths.libraryIndexFile) else {
            await MainActor.run { self.videos = [] }
            return
        }

        if let decoded = try? decoder.decode([VideoAsset].self, from: data) {
            await MainActor.run {
                self.videos = decoded.sorted { $0.createdAt > $1.createdAt }
            }
        }
    }

    func loadCachedVideos() {
        guard let data = try? Data(contentsOf: AppPaths.libraryIndexFile),
              let decoded = try? decoder.decode([VideoAsset].self, from: data) else {
            return
        }
        videos = decoded.sorted { $0.createdAt > $1.createdAt }
    }

    @discardableResult
    func importVideo(from sourceURL: URL) -> Bool {
        let ext = sourceURL.pathExtension
        guard !ext.isEmpty else {
            lastError = "The selected file must have a valid video extension."
            return false
        }
        let targetURL = AppPaths.libraryDirectory.appendingPathComponent("\(UUID().uuidString).\(ext)")

        do {
            try FileManager.default.copyItem(at: sourceURL, to: targetURL)
            var asset = VideoAsset(
                id: UUID(),
                name: sourceURL.deletingPathExtension().lastPathComponent,
                localURL: targetURL,
                duration: 0,
                width: 0,
                height: 0,
                createdAt: Date(),
                tags: []
            )

            let avAsset = AVURLAsset(url: targetURL)
            let durationSeconds = CMTimeGetSeconds(avAsset.duration)
            asset.duration = durationSeconds.isFinite ? durationSeconds : Self.invalidDuration
            if let track = avAsset.tracks(withMediaType: .video).first {
                let transformed = track.naturalSize.applying(track.preferredTransform)
                asset.width = Int(abs(transformed.width))
                asset.height = Int(abs(transformed.height))
            }

            videos.insert(asset, at: 0)
            persist()
            return true
        } catch {
            lastError = error.localizedDescription
            return false
        }
    }

    func removeVideo(id: UUID) {
        guard let index = videos.firstIndex(where: { $0.id == id }) else { return }
        let video = videos.remove(at: index)
        try? FileManager.default.removeItem(at: video.localURL)
        persist()
    }

    func video(with id: UUID?) -> VideoAsset? {
        guard let id else { return nil }
        return videos.first(where: { $0.id == id })
    }

    private func persist() {
        guard let data = try? encoder.encode(videos) else { return }
        try? data.write(to: AppPaths.libraryIndexFile, options: .atomic)
    }
}
