//
//  RegistrationVm.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 18.11.22.
//

import Foundation

protocol GetRegistrationModelProtocol: AnyObject {
    var sexArray: [String] { get }
}

final class RegistrationModel: GetRegistrationModelProtocol {
    
    var sexArray = [ KeysForView.man, KeysForView.woman ]
    
}
