//
//  MenuVc.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 28.11.22.
//

import UIKit

final class MenuVc: UIViewController {
    
    // MARK: Buttons
    private let closeMenuButton: UIButton = {
        let button = OneImageButton(image: UIImage(named: KeysForImage.closeScreenFigma)?.withTintColor(.black, renderingMode: .alwaysOriginal) ?? UIImage())
        button.addTarget(self, action: #selector(popToHomeScreenVc), for: .touchUpInside)
        return button
    }()
    private let cabinetPersonalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(KeysForView.userCabinet, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .jostRegular18()
       // button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()
    private let aboutAppButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(KeysForView.aboutApp, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = .jostRegular18()
            return button
        }()
    private let feedbackButton: UIButton = {
                let button = UIButton(type: .system)
                button.setTitle(KeysForView.feedback, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = .jostRegular18()
                return button
            }()
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(KeysForView.logOut, for: .normal)
        button.setImage(UIImage(named: KeysForImage.backBarButtonItem)?.withTintColor(.black.withAlphaComponent(0.6), renderingMode: .alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
        button.imageView?.trailingAnchor.constraint(equalTo: button.titleLabel!.leadingAnchor, constant: -LayoutConstants.inset11).isActive = true
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
       return button
    }()
    // MARK: Views
    // Stack view
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ self.cabinetPersonalButton, self.aboutAppButton, self.feedbackButton ])
        let horizontalConstraints = LayoutConstants.width90
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = LayoutConstants.inset32
        stackView.alignment = .leading
        return stackView
    }()
    // Separator
    private let separator = SeparatorView(color: .backgroundWhiteColor)
    // MARK: System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperView()
        addView()
        constraints()
    }
}
// MARK: Custom funcs
private extension MenuVc {
    // Set Superview
    func setSuperView() {
        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        view.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0.098, green: 0.101, blue: 0.292, alpha: 0.2).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 10
        layer0.shadowOffset = CGSize(width: -10, height: 0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        var shapes = UIView()
        shapes.frame = view.bounds
        shapes.clipsToBounds = true
        view.addSubview(shapes)

        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
    }
    // Add views func
    func addView() {
        self.view.addSubview(closeMenuButton)
        self.view.addSubview(buttonsStackView)
        self.view.addSubview(separator)
        self.view.addSubview(logoutButton)
    }
}
// MARK: Actions
private extension MenuVc {

    // Hide MeuVc
   @objc func popToHomeScreenVc() {
       navigationController?.popViewController(animated: true)
    }
    // Log out
   @objc func logOut() {
       navigationController?.popToRootViewController(animated: true)
    }
}
// MARK: Constraints
private extension MenuVc {
    func constraints() {
        NSLayoutConstraint.activate([
            // Close menu button
            closeMenuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.inset23),
            closeMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset17),
            closeMenuButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width14),
            closeMenuButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height14),
            // StackView buttons
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.inset100),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset38),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset130),
            buttonsStackView.heightAnchor.constraint(equalToConstant: LayoutConstants.height200),
            // Separator
            separator.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: LayoutConstants.inset40),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset38),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset38),
            separator.heightAnchor.constraint(equalToConstant: LayoutConstants.inset1),
            // Log out button
            logoutButton.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: LayoutConstants.inset30),
            logoutButton.leadingAnchor.constraint(equalTo: separator.leadingAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width77),
            logoutButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height50)
        ])
    }
}
