//
//  CheckBoxButton.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 21.11.22.
//

import UIKit

class CheckboxButton: UIButton {
    init() {
        super.init(frame: .zero)
        setCheckBoxButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CheckboxButton {
    private func setCheckBoxButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = LayoutConstants.inset1
        self.layer.borderColor = UIColor.borderGrayColor.cgColor
        self.layer.backgroundColor = UIColor.backgroundWhiteColor.cgColor
        self.setImage(UIImage.init(named: KeysForImage.checkBoxOn), for: .selected)
        self.addTarget(self, action: #selector(toggleCheckboxSelection), for: .touchUpInside)
    }
}
private extension CheckboxButton {
    @objc private func toggleCheckboxSelection() {
        self.isSelected = !self.isSelected
    }
}
