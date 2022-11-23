//
//  SeparatorView.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 23.11.22.
//

import UIKit

final class SeparatorView: UIView {
    convenience init(color: UIColor) {
        self.init()
        setSeparator(color: color)
    }
}

private extension SeparatorView {
    private func setSeparator(color: UIColor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
    }
}
