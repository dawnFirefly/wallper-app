import SwiftUI

final class WallperUI: ObservableObject {
    func makeRootView(
        licenseManager: LicenseManager,
        videoLibrary: VideoLibraryStore,
        filterStore: VideoFilterStore,
        deviceLoader: DeviceLoader
    ) -> some View {
        DashboardView(
            licenseManager: licenseManager,
            videoLibrary: videoLibrary,
            filterStore: filterStore,
            deviceLoader: deviceLoader
        )
    }
}

private struct DashboardView: View {
    @ObservedObject var licenseManager: LicenseManager
    @ObservedObject var videoLibrary: VideoLibraryStore
    @ObservedObject var filterStore: VideoFilterStore
    @ObservedObject var deviceLoader: DeviceLoader

    @State private var selectedVideoID: UUID?

    private var filteredVideos: [VideoAsset] {
        filterStore.apply(to: videoLibrary.videos)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Wallper")
                    .font(.title2).bold()
                Spacer()
                let statusText = licenseManager.status.rawValue.capitalized
                let statusIcon = licenseManager.status == .valid ? "checkmark.circle.fill" : "exclamationmark.triangle.fill"
                Label("License: \(statusText)", systemImage: statusIcon)
                    .foregroundStyle(licenseManager.status == .valid ? .green : .orange)
            }

            HStack {
                Picker("Filter", selection: $filterStore.selectedFilterName) {
                    ForEach(filterStore.availableFilters, id: \.name) { filter in
                        Text(filter.name).tag(filter.name)
                    }
                }
                .frame(width: 140)
                TextField("Search videos", text: $filterStore.query)
                Button("Import") {
                    WindowManager.shared.importVideoIntoLibrary(videoLibrary)
                }
            }

            List(selection: $selectedVideoID) {
                ForEach(filteredVideos) { video in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(video.name).font(.headline)
                            Text("\(video.resolutionLabel) • \(Int(video.duration))s")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .tag(video.id)
                }
            }
            .frame(minHeight: 260)

            HStack {
                Button("Apply to All Screens") {
                    guard let video = videoLibrary.video(with: selectedVideoID) else { return }
                    VideoWallpaperManager.shared.setVideoAsWallpaper(from: video.localURL, screenIndex: nil, applyToAll: true)
                }
                .disabled(selectedVideoID == nil)

                Button("Stop") {
                    VideoWallpaperManager.shared.stopCurrentWallpaper()
                }

                Button("Delete Selected") {
                    guard let selectedVideoID else { return }
                    videoLibrary.removeVideo(id: selectedVideoID)
                    self.selectedVideoID = nil
                }
                .disabled(selectedVideoID == nil)

                Spacer()
            }

            HStack {
                Toggle("Restore on launch", isOn: Binding(
                    get: { UserDefaults.standard.bool(forKey: "restoreLastWallpapers") },
                    set: { UserDefaults.standard.set($0, forKey: "restoreLastWallpapers") }
                ))
                Toggle("Pause on battery", isOn: Binding(
                    get: { UserDefaults.standard.bool(forKey: "pauseOnBattery") },
                    set: { UserDefaults.standard.set($0, forKey: "pauseOnBattery") }
                ))
                Toggle("Adapt menu bar", isOn: Binding(
                    get: { UserDefaults.standard.bool(forKey: "adaptMenuBar") },
                    set: { UserDefaults.standard.set($0, forKey: "adaptMenuBar") }
                ))
            }

            if let snapshot = deviceLoader.snapshot {
                Text("Device: \(snapshot.hostName) • \(snapshot.osVersion) • Screens: \(snapshot.screens.count)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .frame(minWidth: 740, minHeight: 520)
    }
}
