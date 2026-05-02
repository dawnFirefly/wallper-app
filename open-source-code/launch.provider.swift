import Foundation

extension LicenseManager {
    private static var didKickOff = false

    func startCheckIfNeeded() {
        guard !Self.didKickOff, !isChecked else { return }
        Self.didKickOff = true
        let hwid = HWIDProvider.getHWID()
        checkLicense(for: hwid)
    }
}
