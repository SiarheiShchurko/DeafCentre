//
//  SecendaryLabel.swift
//  DeafInfoCenter
//
//  Created by Alinser Shchurko on 16.11.22.
//
import UIKit

final class UniversalLabel: UILabel {
    
    var titleText: String?
    var color: UIColor?
    var labelFont: UIFont?
    init(titleText: String, color: UIColor, labelFont: UIFont) {
        self.titleText = titleText
        self.color = color
        self.labelFont = labelFont
        super.init(frame: .zero)
        configure(titleText: titleText, color: color, labelFont: labelFont)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - SetUp label
private extension UniversalLabel {
    private func configure(titleText: String, color: UIColor, labelFont: UIFont) {
        
        self.text = titleText
        self.textColor = color
        self.font = labelFont
        self.numberOfLines = 0
        self.textAlignment = .left
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

