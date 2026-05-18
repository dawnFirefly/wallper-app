import Foundation

struct EnvConfig: Codable {
    var updateFeedURL: URL?
    var bannedHWIDs: [String]
    var licenseSalt: String

    static let `default` = EnvConfig(
        updateFeedURL: nil,
        bannedHWIDs: [],
        licenseSalt: "WALLPER-OSS"
    )
}

final class Env {
    static let shared = Env()

    private(set) var config: EnvConfig = .default
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    private init() {
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601
    }

    func loadSyncFromLambda() {
        if let data = try? Data(contentsOf: AppPaths.envFile),
           let loaded = try? decoder.decode(EnvConfig.self, from: data) {
            config = loaded
            return
        }

        config = .default
        persist()
    }

    func persist() {
        guard let data = try? encoder.encode(config) else { return }
        try? data.write(to: AppPaths.envFile, options: .atomic)
    }
}
