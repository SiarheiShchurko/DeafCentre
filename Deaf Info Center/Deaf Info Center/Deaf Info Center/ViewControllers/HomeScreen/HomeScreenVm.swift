//
//  HomeScreenVm.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 26.11.22.
//

import Foundation
protocol HomeScreenModelProtocol: AnyObject {
    func loadDate()
    var timer: Timer? { get set }
}
protocol GiveAwayDateProtocol: AnyObject {
    func giveAwayTime(time: String)
    func giveAwayDate(date: String)
}

final class HomeScreenVm: HomeScreenModelProtocol {
    
    weak var dateDelegate: GiveAwayDateProtocol?
    
    // MARK: Date service
    let dateService = DateService()
    
    var timer: Timer?
    
    var time: String = "" {
        didSet {
            dateDelegate?.giveAwayTime(time: time)
        }
    }
    var date: String = "" {
        didSet {
            dateDelegate?.giveAwayDate(date: date)
        }
    }
    
    // MARK: Func which search time
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(loadDate), userInfo: nil, repeats: true)
        print("Timer work")
    }
    
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


