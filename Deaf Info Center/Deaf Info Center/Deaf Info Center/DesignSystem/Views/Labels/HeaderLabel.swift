//
//  HeaderLabel.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 19.11.22.
//

import UIKit

final class HeaderLabel: UILabel {
    convenience init(text: String) {
        self.init()
        configure(with: text)
    }
}

// MARK: - SetUp label
private extension HeaderLabel {
    private func configure(with text: String) {
        self.text = text
        self.textColor = .white
        self.font = .jostMedium26()
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
