//
//  CheckEmailService.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 24.11.22.
//

import Foundation

protocol CheckRegistrationFormProtocol: AnyObject {
   func isValidEmail(email: String) -> Bool
   func isValidPssword(password: String) -> Bool
}
final class CheckRegistrationFormService: CheckRegistrationFormProtocol {
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
    }
    func isValidPssword(password: String) -> Bool {
        let minLenght = 12
        let maxLenght = 12
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{\(minLenght),\(maxLenght)}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
