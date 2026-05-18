import Foundation
import Combine
import AppKit

final class UpdateManager: ObservableObject {
    static let shared = UpdateManager()

    @Published private(set) var didFinishCheck = false
    @Published private(set) var isUpdateAvailable = false
    @Published private(set) var isChecking = false
    private(set) var updateInfo: UpdateInfo?

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    private init() {
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    }

    func checkForUpdate() {
        didFinishCheck = false
        isChecking = true

        Task {
            let remote = await fetchRemoteFeed()
            let local = fetchLocalFeed()
            let available = remote ?? local

            await MainActor.run {
                self.updateInfo = available
                let current = self.currentVersion
                if let available, !current.isEmpty {
                    self.isUpdateAvailable = self.isNewer(available.version, than: current)
                } else {
                    self.isUpdateAvailable = false
                }
                self.didFinishCheck = true
                self.isChecking = false
            }
        }
    }

    func startUpdate() {
        guard let url = updateInfo?.downloadURL else { return }
        NSWorkspace.shared.open(url)
    }

    private var currentVersion: String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
              !version.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("[Update] Missing bundle version; skipping update availability check.")
            return ""
        }
        return version
    }

    private func fetchLocalFeed() -> UpdateInfo? {
        guard let data = try? Data(contentsOf: AppPaths.updateFeedFile) else { return nil }
        return try? decoder.decode(UpdateInfo.self, from: data)
    }

    private func fetchRemoteFeed() async -> UpdateInfo? {
        guard let url = Env.shared.config.updateFeedURL else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try decoder.decode(UpdateInfo.self, from: data)
            persist(decoded)
            return decoded
        } catch {
            return nil
        }
    }

    private func persist(_ info: UpdateInfo) {
        guard let data = try? encoder.encode(info) else { return }
        try? data.write(to: AppPaths.updateFeedFile, options: .atomic)
    }

    private func isNewer(_ lhs: String, than rhs: String) -> Bool {
        let left = lhs.split(separator: ".").compactMap { Int($0) }
        let right = rhs.split(separator: ".").compactMap { Int($0) }
        let count = max(left.count, right.count)
        for i in 0..<count {
            let l = i < left.count ? left[i] : 0
            let r = i < right.count ? right[i] : 0
            if l != r { return l > r }
        }
        return false
    }
}
