//
//  RadioButton.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 22.11.22.
//

import UIKit
class RadioButton: UIButton {
    convenience init() {
        self.init(type: .custom)
        setRadioButton()
    }
}

private extension RadioButton {
    private func setRadioButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setBackgroundImage(UIImage.init(named: KeysForImage.radioOffFigma), for: .normal)
        self.setBackgroundImage(UIImage.init(systemName: KeysForImage.radioOnSystem)?.withTintColor(.backgroundWhiteColor, renderingMode: .alwaysOriginal).withTintColor(.purpoureLight, renderingMode: .alwaysOriginal), for: .selected)
        self.contentMode = .center
    }
}

