//
//  ProfileSetVc.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 30.11.22.
//

import UIKit
final class PersonalCabinetVc: UIViewController {
    // MARK: Constant
    let pickerVc = UIImagePickerController()
    // Percent hight display which takened from header view
    private let percentHeightTaken = 0.38
    // MARK: Labels
    private let personalCabinetLabel = UniversalLabel(titleText: KeysForView.personalCabinet, color: .white, labelFont: .jostMedium26() ?? UIFont())
    private let userNameLabel: UILabel = {
        let label = UniversalLabel(titleText: "User Name", color: .eerieBlack, labelFont: .jostMedium22() ?? UIFont())
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    // MARK: Buttons
    // Back button item
    private let backButtonItem: UIButton = {
        let button = BackButtonItem()
        button.addTarget(self, action: #selector(backToHomeScreen), for: .touchUpInside)
        return button
    }()
    private let changeFotoButton: UIButton = {
        let button = ConfirmButton(titleButton: KeysForView.changedFoto, colorButton: .purpoureLight, fontButton: .jostRegular15() ?? UIFont(), textColorButton: .white, buttonImage: UIImage(), typeButton: .system)
        button.isEnabled = true
        button.layer.cornerRadius = LayoutConstants.inset12
        button.titleLabel?.contentMode = .center
        button.addTarget(self, action: #selector(changedFoto), for: .touchUpInside)
        return button
    }()
    private let personalDataButton = ProfileButton(leftIcon: UIImage(named: KeysForImage.personFigma), title: KeysForView.personalData)
    private let changePasswordButton = ProfileButton(leftIcon: UIImage(named: KeysForImage.keyFigma), title: KeysForView.changePassword)
    private let appLanguageButton = ProfileButton(leftIcon: UIImage(named: KeysForImage.personFigma), title: KeysForView.changeLanguage)
    // MARK: Views
    // Header view
    private let headerView = HeaderView()
    // Container view
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = LayoutConstants.inset20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()
    // Image view for user avatar
    private let userAvatar: UIImageView = {
        let imageView = ImageViewForAvatar(avatarImage: UIImage(named: KeysForImage.videoCallIFigma) ?? UIImage())
        imageView.layer.cornerRadius = LayoutConstants.width113 / LayoutConstants.inset2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.personalDataButton, self.changePasswordButton, self.appLanguageButton])
        let horizontalConstraints = LayoutConstants.width44
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    // MARK: System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addShadows()
        addView()
        constraints()
       // pickerVc.delegate = self
    }
}
// MARK: Actions
private extension PersonalCabinetVc {
    // Back to home vc
    @objc func backToHomeScreen() {
        if let homeScreenVc = self.navigationController?.viewControllers.filter { $0 is HomeScreenVc }.first {
            navigationController?.popToViewController(homeScreenVc, animated: true)
        }
    }
    // Change foto action
    @objc func changedFoto() {
        self.pickerVc.sourceType = .photoLibrary
        present(pickerVc, animated: true)
    }
}
// MARK: Custon funcs
private extension PersonalCabinetVc {
    func addView() {
        view.addSubview(headerView)
        headerView.addSubview(backButtonItem)
        headerView.addSubview(personalCabinetLabel)
        view.addSubview(containerView)
        containerView.addSubview(userAvatar)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(changeFotoButton)
        containerView.addSubview(buttonsStackView)
    }
}
// MARK: Constraints
private extension PersonalCabinetVc {
    func constraints() {
        NSLayoutConstraint.activate([
            // Header view
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -LayoutConstants.inset10),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LayoutConstants.inset10),
            headerView.heightAnchor.constraint(equalToConstant: LayoutConstants.displayHeight * percentHeightTaken),
            // Back button item
            backButtonItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.inset24),
            backButtonItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset16),
            backButtonItem.widthAnchor.constraint(equalToConstant: LayoutConstants.width25),
            backButtonItem.heightAnchor.constraint(equalToConstant: LayoutConstants.height13),
            // History calls label
            personalCabinetLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            personalCabinetLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height30),
            personalCabinetLabel.topAnchor.constraint(equalTo: backButtonItem.bottomAnchor, constant: LayoutConstants.inset10),
            // Container view
            containerView.topAnchor.constraint(equalTo: personalCabinetLabel.bottomAnchor, constant: LayoutConstants.inset16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset16),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // User avatar
            userAvatar.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.inset65),
            userAvatar.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userAvatar.widthAnchor.constraint(equalToConstant: LayoutConstants.width113),
            userAvatar.heightAnchor.constraint(equalToConstant: LayoutConstants.height113),
            // User name label
            userNameLabel.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: LayoutConstants.inset16),
            userNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.inset16),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.inset16),
            userNameLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height24),
            // Change foto button
            changeFotoButton.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: LayoutConstants.inset8),
            changeFotoButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width220),
            changeFotoButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            changeFotoButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height24),
            // Personal cabinet label
            buttonsStackView.topAnchor.constraint(equalTo: changeFotoButton.bottomAnchor, constant: LayoutConstants.inset40),
            buttonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.inset16),
            buttonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.inset16),
        ])
    }
}

// MARK: Delegate methods for PickerView
//extension PersonalCabinetVc: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true)
//    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        if let image = info[.originalImage] as? UIImage {
//           // images.append(image)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [ weak self ] in
//                guard let self = self else { return }
//                self.userAvatar.image = image
//            }
//        }
//        picker.dismiss(animated: true)
//    }
//}
