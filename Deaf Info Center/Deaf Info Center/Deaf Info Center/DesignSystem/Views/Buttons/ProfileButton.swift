//
//  ProfileButton.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 30.11.22.
//

import UIKit
// MARK: Class sample button for profile user disp
final class ProfileButton: UIButton {
    // MARK: Properties
    let leftIcon: UIImage?
    let titleLab: String
    let disclosureIndicator = UIImage(named: KeysForImage.rightArrowFigma)
    // MARK: Width ancors
    private let widthConstraintsForButton = 32.0
    // MARK: Init
    init(leftIcon: UIImage?, title: String) {
        self.leftIcon = leftIcon
        self.titleLab = title
        super.init(frame: .zero)
        self.setButton(leftIcon: leftIcon, title: title)
        constraints()
    }
    // MARK: Animation button
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: LayoutConstants.duration) {
                 self.isHighlighted ? (self.backgroundColor = .black.withAlphaComponent(0.2)) : (self.backgroundColor = .clear)
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Separator
    private let separator = SeparatorView(color: .backgroundWhiteColor)
}
// MARK: Profile Button set
  private extension ProfileButton {
    private func setButton(leftIcon: UIImage?, title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        // MARK: Check button
      //  backgroundColor = .primaryWhiteSnow
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        self.setImage(disclosureIndicator?.withTintColor(.purpoureLight, renderingMode: .alwaysOriginal), for: .normal)
        // titleLabel set
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.jostMedium17()
        self.titleLabel?.textAlignment = .left
        // icons set
        let iconImage = UIImageView()
        iconImage.frame = CGRect(x: LayoutConstants.inset16, y: LayoutConstants.inset20, width: LayoutConstants.width20, height: LayoutConstants.height17)
        iconImage.image = leftIcon?.withTintColor(.purpoureLight, renderingMode: .alwaysOriginal)
        iconImage.contentMode = .left
        // self setup
        self.layer.cornerRadius = LayoutConstants.inset8
        // addSubview
        self.addSubview(iconImage)
        self.addSubview(separator)
    }
}
// MARK: Constraints for button
private extension ProfileButton {
     func constraints() {
         self.widthAnchor.constraint(equalToConstant: LayoutConstants.displayWidth - LayoutConstants.width44).isActive = true
         self.heightAnchor.constraint(equalToConstant: LayoutConstants.height60).isActive = true
        self.imageView?.widthAnchor.constraint(equalToConstant: LayoutConstants.width20).isActive = true
        self.imageView?.heightAnchor.constraint(equalToConstant: LayoutConstants.height17).isActive = true
        self.titleLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: LayoutConstants.inset48).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.inset17).isActive = true
        self.titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -LayoutConstants.inset48).isActive = true
        self.imageView?.leadingAnchor.constraint(equalTo: titleLabel!.trailingAnchor, constant: LayoutConstants.inset20).isActive = true
        imageView?.contentMode = .right
         separator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
         separator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
         separator.heightAnchor.constraint(equalToConstant: LayoutConstants.inset1).isActive = true
         separator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
