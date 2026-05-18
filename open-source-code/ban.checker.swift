import Foundation

final class BanChecker {
    func checkBanStatus(completion: @escaping (Bool) -> Void) {
        let hwid = HWIDProvider.getHWID()
        let banned = Env.shared.config.bannedHWIDs.contains(hwid)
        completion(banned)
    }
}
