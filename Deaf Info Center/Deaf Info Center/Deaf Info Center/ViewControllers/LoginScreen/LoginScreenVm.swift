//
//  UserRegistrationVm.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 17.11.22.
//

import Foundation
// MARK: Protocol for VM
protocol LoginScreenModelProtocol: AnyObject {
    func loadDate()
   // func startTimer()
    var time: String { get set }
    var date: String { get set }
    var updateTime: (() -> Void)? { get set }
    var updateDate: (() -> Void)? { get set }
    var timer: Timer? { get set }
}
// MARK: VM Class
final class LoginPageVm: LoginScreenModelProtocol {
    let dateService: DateService = DateService()
    var timer: Timer?
    var updateTime: (() -> Void)?
    var updateDate: (() -> Void)?
    var time: String = "" {
        didSet {
            updateTime?()
        }
    }
    var date: String = "" {
        didSet {
            updateDate?()
        }
    }
    // MARK: Func which search time
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(loadDate), userInfo: nil, repeats: true)
        print("Timer work")
    }
    // MARK: Func when we get date and time
   @objc func loadDate() {
       DispatchQueue.global(qos: .background).async {
           self.dateService.getDate { [ weak self ] date in
               guard let self = self else { return }
               // load time
               let timeFormatter = DateFormatter()
               timeFormatter.dateFormat = "HH:mm"
               let strTime = timeFormatter.string(from: date)
               strTime == self.time ? print("Its current time") : (self.time = strTime)
               
               // load date
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "dd.MM.yyyy"
               let strDate = dateFormatter.string(from: date)
               strDate == self.date ? print("Its current date") : (self.date = strDate)
           }
       }
       startTimer()
   }
}
   
    
        
      

    


