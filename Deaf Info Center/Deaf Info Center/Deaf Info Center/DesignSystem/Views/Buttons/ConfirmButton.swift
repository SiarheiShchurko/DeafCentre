//
//  ConfirmButton.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 22.11.22.
//

import UIKit

class ConfirmButton: UIButton {
    var titleButton: String?
    var colorButton: UIColor?
    var fontButton: UIFont?
    var textColorButton: UIColor?
    var buttonImage: UIImage?
    var typeButton: ButtonType
    
    init(titleButton: String?, colorButton: UIColor?, fontButton: UIFont?, textColorButton: UIColor?, buttonImage: UIImage?, typeButton: ButtonType) {
        self.titleButton = titleButton
        self.colorButton = colorButton
        self.fontButton = fontButton
        self.textColorButton = textColorButton
        self.buttonImage = buttonImage
        self.typeButton = typeButton
        super.init(frame: .zero)
        setRadioButton(titleButton: titleButton, colorButton: colorButton, fontButton: fontButton, textColorButton: textColorButton, buttonImage: buttonImage ?? UIImage())
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension ConfirmButton {
    private func setRadioButton(titleButton: String?, colorButton: UIColor?, fontButton: UIFont?, textColorButton: UIColor?, buttonImage: UIImage) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isEnabled = false
        self.setTitle(titleButton, for: .normal)
        self.setTitleColor(textColorButton, for: .normal)
        self.setTitleColor(textColorButton?.withAlphaComponent(0.2), for: .highlighted)
        self.setTitleColor(textColorButton?.withAlphaComponent(0.2), for: .disabled)
        self.titleLabel?.font = fontButton
        self.backgroundColor = colorButton
        self.setImage(buttonImage, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.layer.cornerRadius = LayoutConstants.inset20
        self.clipsToBounds = true
    }
}
private extension ConfirmButton {
    private func constraints() {
        self.imageView?.widthAnchor.constraint(equalToConstant: LayoutConstants.width20).isActive = true
        self.imageView?.heightAnchor.constraint(equalToConstant: LayoutConstants.height17).isActive = true
        self.titleLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.inset17).isActive = true
        self.titleLabel?.trailingAnchor.constraint(equalTo: self.imageView!.leadingAnchor, constant: -LayoutConstants.inset10).isActive = true
        imageView?.contentMode = .right
    }
}
