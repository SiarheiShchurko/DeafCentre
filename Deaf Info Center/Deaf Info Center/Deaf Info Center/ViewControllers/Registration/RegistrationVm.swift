//
//  RegistrationVm.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 18.11.22.
//

import Foundation
// MARK: RegistrationModel protocol
protocol RegistrationModelProtocol: AnyObject {
    func checkEmailAndPassword(email: String?, password: String?)
    var sexArray: [String] { get }
    var degreeSpecifyArray: [ String ] { get }
    var update: (() -> Void)? { get set }
    var updateError: (() -> Void)? { get set }
}
// MARK: RegistrationModel class
final class RegistrationModel: RegistrationModelProtocol {
   
    // Check Service
    let checkRegistrFormService: CheckRegistrationFormProtocol = CheckRegistrationFormService()
    // Update information funcs
    var update: (() -> Void)?
    var updateError: (() -> Void)?
    // Array for changed sex
    var sexArray: [String] = [ KeysForView.man, KeysForView.woman ]
    var degreeSpecifyArray: [String] = [ KeysForView.severeDegree, KeysForView.accentuatedDegree, KeysForView.mediumDegree ]
    // Func who start service check
    func checkEmailAndPassword(email: String?, password: String?) {
        let emailIsValid = checkRegistrFormService.isValidEmail(email: email ?? "")
        let passwordIsValid = checkRegistrFormService.isValidPssword(password: password ?? "")
        let isValid = (emailIsValid) && (passwordIsValid)
        checkResult(isValid)
    }
    // Control check result geting from service
    private func checkResult(_ object: Bool) {
        switch object {
        case true:
            self.update?()
        case false:
            self.updateError?()
        }
    }
}
