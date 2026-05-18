import Foundation
import CoreGraphics

struct VideoAsset: Codable, Identifiable, Hashable {
    let id: UUID
    var name: String
    var localURL: URL
    var duration: TimeInterval
    var width: Int
    var height: Int
    var createdAt: Date
    var tags: [String]

    var resolutionLabel: String { "\(width)x\(height)" }
}

enum LicenseStatus: String, Codable {
    case unverified
    case free
    case valid
    case invalid

    var displayLabel: String {
        switch self {
        case .unverified: return "Unverified"
        case .free: return "Free"
        case .valid: return "Activated"
        case .invalid: return "Invalid"
        }
    }
}

struct LicenseRecord: Codable {
    var hwid: String
    var token: String?
    var firstSeenAt: Date
    var lastCheckedAt: Date
    var status: LicenseStatus
}

struct UpdateInfo: Codable, Equatable {
    let version: String
    let notes: String
    let downloadURL: URL?
    let mandatory: Bool
    let releasedAt: Date
}

struct DeviceSnapshot: Codable {
    let hwid: String
    let hostName: String
    let osVersion: String
    let screens: [ScreenSnapshot]
    let capturedAt: Date
}

struct ScreenSnapshot: Codable {
    let id: String
    let width: Int
    let height: Int
    let scale: Double
    let isPrimary: Bool
}

struct DisplayConfig: Codable {
    var scale: CGFloat = 1.0
    var offset: CGSize = .zero
}
