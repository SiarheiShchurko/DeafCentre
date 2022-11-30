//
//  GetUserCallsStory.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 29.11.22.
//

import Foundation
import UIKit
final class GetUserCallsService {
    let sampleOperator = UserCallsStored(avatar: UIImage(), operatorName: "Boris", date: Date(), duration: 65)
    
    func fetchUserCalls(complition: @escaping( (UserCallsStored) -> Void )) {
        DispatchQueue.main.async {
            complition(self.sampleOperator)
        }
    }
}
