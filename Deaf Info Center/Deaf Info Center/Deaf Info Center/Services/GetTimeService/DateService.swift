//
//  DateService.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 17.11.22.
//

import Foundation

final class DateService {
    func getDate(complition: @escaping( (Date) -> Void )) {
        DispatchQueue.main.async {
            complition(Date())
        }
    }
}
