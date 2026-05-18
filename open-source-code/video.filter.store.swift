import Foundation
import Combine

enum VideoFilterKind: String, CaseIterable, Identifiable {
    case all = "All"
    case hd = "HD+"
    case uhd = "4K+"
    case short = "< 30s"

    var id: String { rawValue }
}

struct VideoFilter: Identifiable {
    let id = UUID()
    let name: String
    let kind: VideoFilterKind
}

extension VideoFilter {
    static let all = VideoFilter(name: VideoFilterKind.all.rawValue, kind: .all)
    static let hd = VideoFilter(name: VideoFilterKind.hd.rawValue, kind: .hd)
    static let uhd = VideoFilter(name: VideoFilterKind.uhd.rawValue, kind: .uhd)
    static let short = VideoFilter(name: VideoFilterKind.short.rawValue, kind: .short)
}

final class VideoFilterStore: ObservableObject {
    @Published private(set) var availableFilters: [VideoFilter] = [.all]
    @Published var selectedFilterName: String = "All"
    @Published var query: String = ""

    func fetchDynamicFilters() async {
        await MainActor.run {
            self.availableFilters = [.all, .hd, .uhd, .short]
            self.selectedFilterName = "All"
        }
    }

    func apply(to videos: [VideoAsset]) -> [VideoAsset] {
        let base: [VideoAsset]
        if let filter = availableFilters.first(where: { $0.name == selectedFilterName }) {
            switch filter.kind {
            case .all:
                base = videos
            case .hd:
                base = videos.filter { $0.width >= 1280 }
            case .uhd:
                base = videos.filter { $0.width >= 3840 }
            case .short:
                base = videos.filter { $0.duration <= 30 }
            }
        } else {
            base = videos
        }
        guard !query.isEmpty else { return base }
        return base.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
