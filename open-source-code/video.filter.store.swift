import Foundation
import Combine

struct VideoFilter: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let predicate: (VideoAsset) -> Bool

    static let all = VideoFilter(name: "All") { _ in true }
    static let hd = VideoFilter(name: "HD+") { $0.width >= 1280 }
    static let uhd = VideoFilter(name: "4K+") { $0.width >= 3840 }
    static let short = VideoFilter(name: "< 30s") { $0.duration <= 30 }
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
            base = videos.filter(filter.predicate)
        } else {
            base = videos
        }
        guard !query.isEmpty else { return base }
        return base.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
