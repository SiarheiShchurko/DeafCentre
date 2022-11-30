//
//  HistoryCallsVm.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 29.11.22.
//

import Foundation
import UIKit

protocol HistoryCallsModelProtocol: AnyObject {
    var callsArray: [UserCallsStored] { get set }
    func loadUserCalls() 
}
protocol UserCallsTViewDelegateProtocol: AnyObject {
    func delegateArrayCalls(callsArray: [UserCallsStored])
}
final class HistoryCallsVm: HistoryCallsModelProtocol {
    // MARK: Service
    let getUserCallsService = GetUserCallsService()
    //MARK: Delegate
    weak var delegateCountCells: UserCallsTViewDelegateProtocol?
  //  private var operatorCall = UserCallsStored(avatar: UIImage(), operatorName: "Galina")
//    // MARK: Array
    var callsArray: [UserCallsStored] = [UserCallsStored(avatar: UIImage(named: KeysForImage.appLogoButton) ?? UIImage(), operatorName: "Galina", date: Date(), duration: 10), UserCallsStored(avatar: UIImage(named: KeysForImage.finishCallFigma) ?? UIImage(), operatorName: "Pavel", date: Date(timeInterval: 100, since: Date()), duration: 5054)]
 //   {
//        didSet { delegateCountCells?.delegateArrayCalls(callsArray: callsArray) }
//    }
//    // MARK: Load stored calls in array
    func loadUserCalls() {
        getUserCallsService.fetchUserCalls { [ weak self ] callsModel in
            guard let self = self else { return }
//            self.callsArray.append(callsModel)
        }
    }
}
