import Foundation
import Combine

final class LicenseManager: ObservableObject {
    @Published private(set) var isChecked = false
    @Published private(set) var status: LicenseStatus = .unverified
    @Published private(set) var lastError: String?

    private var record: LicenseRecord?
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init() {
        decoder.dateDecodingStrategy = .iso8601
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? Data(contentsOf: AppPaths.licenseFile),
           let saved = try? decoder.decode(LicenseRecord.self, from: data) {
            record = saved
            status = saved.status
            isChecked = true
        }
    }

    func checkFirstSeen(for hwid: String) {
        if var record {
            if record.hwid != hwid {
                record.hwid = hwid
                record.firstSeenAt = Date()
                record.lastCheckedAt = Date()
                record.status = .unverified
                self.record = record
                persist()
            }
            return
        }

        let created = LicenseRecord(
            hwid: hwid,
            token: nil,
            firstSeenAt: Date(),
            lastCheckedAt: Date(),
            status: .unverified
        )
        record = created
        persist()
    }

    func checkLicense(for hwid: String) {
        var record = self.record ?? LicenseRecord(
            hwid: hwid,
            token: nil,
            firstSeenAt: Date(),
            lastCheckedAt: Date(),
            status: .unverified
        )

        record.hwid = hwid
        record.lastCheckedAt = Date()

        if let token = record.token, !token.isEmpty {
            let expected = Self.expectedToken(for: hwid, salt: Env.shared.config.licenseSalt)
            if token == expected {
                record.status = .valid
                status = .valid
                lastError = nil
            } else {
                record.status = .invalid
                status = .invalid
                lastError = "Invalid activation token."
            }
        } else {
            record.status = .valid
            status = .valid
            lastError = nil
        }

        isChecked = true
        self.record = record
        persist()
    }

    @discardableResult
    func activate(token: String, hwid: String) -> Bool {
        var record = self.record ?? LicenseRecord(
            hwid: hwid,
            token: nil,
            firstSeenAt: Date(),
            lastCheckedAt: Date(),
            status: .unverified
        )
        record.token = token
        self.record = record
        checkLicense(for: hwid)
        return status == .valid
    }

    func deactivate() {
        record?.token = nil
        record?.status = .unverified
        status = .unverified
        isChecked = false
        persist()
    }

    private func persist() {
        guard let record, let data = try? encoder.encode(record) else { return }
        try? data.write(to: AppPaths.licenseFile, options: .atomic)
    }

    private static func expectedToken(for hwid: String, salt: String) -> String {
        let seed = Array("\(salt)-\(hwid)".utf8)
        let hash = seed.reduce(UInt64(5381)) { partial, byte in
            ((partial << 5) &+ partial) &+ UInt64(byte)
        }
        return "WALLPER-\(String(hash, radix: 36).uppercased())"
    }
}
