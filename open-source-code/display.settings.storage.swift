import Foundation

enum DisplaySettingsStorage {
    private static let keyPrefix = "wallper.display."
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()

    static func load(for screenID: String) -> DisplayConfig? {
        let key = keyPrefix + screenID
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? decoder.decode(DisplayConfig.self, from: data) else {
            return nil
        }
        return decoded
    }

    static func save(_ config: DisplayConfig, for screenID: String) {
        let key = keyPrefix + screenID
        guard let data = try? encoder.encode(config) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    static func clear(for screenID: String) {
        UserDefaults.standard.removeObject(forKey: keyPrefix + screenID)
    }
}
