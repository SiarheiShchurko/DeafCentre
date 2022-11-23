//
//  ForRegistrationTfLabel.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 21.11.22.
//

import UIKit

final class RegistrationTfLabel: UILabel {
    var titleText: String?
    var redStar: String?
    init(titleText: String, redStar: String) {
        self.titleText = titleText
        self.redStar = redStar
        super.init(frame: .zero)
        configure(titleText: titleText, redStar: redStar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp label

private extension RegistrationTfLabel {
    private func configure(titleText: String, redStar: String) {
        let unitedStroke = titleText + redStar
        let redStarLenght = redStar.count
        let titleTextArrStr = NSMutableAttributedString(string: unitedStroke)
            titleTextArrStr.addAttributes([.foregroundColor : UIColor.eerieBlack], range: NSRange(location: 0, length: titleText.count))
            titleTextArrStr.addAttributes([.foregroundColor : UIColor.red], range: NSRange(location: unitedStroke.count - 1, length: redStarLenght))
            let redStarArrStr = NSMutableAttributedString(string: redStar)
            redStarArrStr.addAttributes([.foregroundColor : UIColor.red], range: NSRange(location: 0, length: redStar.count))
            self.font = .jostRegular17()
            self.textAlignment = .left
            self.attributedText = titleTextArrStr
        
    }
}


