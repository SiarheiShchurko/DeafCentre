//
//  ViewController.swift
//  DeafInfoCenter
//
//  Created by Alinser Shchurko on 16.11.22.
//

import UIKit
import Foundation

class LoginScreenVc: UIViewController {
    // MARK: Model let
    private let loginPageModel = LoginPageVm()
    // MARK: Labels
    // Support label
    private let supportLabel = UniversalLabel(titleText: KeysForView.support, color: .whiteWithAlpha40, labelFont: .jostRegular15() ?? UIFont())
    // Change lang label
    private let didChangeLangLabel = UniversalLabel(titleText: KeysForView.shortLangRu, color: .whiteWithAlpha40, labelFont: .jostRegular15() ?? UIFont())
    // Time label
    private lazy var timeLabel: UILabel = {
        let label = UniversalLabel(titleText: "", color: .white, labelFont: .jostRegular50() ?? UIFont())
        label.textAlignment = .center
        return label
    }()
    // Date label
    private lazy var dateLabel: UILabel = {
        let label = UniversalLabel(titleText: "", color: .white, labelFont: .jostRegular14() ?? UIFont())
        label.textAlignment = .center
        return label
    }()
    // MARK: Text fields
    // EmailTextField
    private lazy var emailTextField: UITextField = {
        let textField = LoginDisplayTextField(placeholdere: KeysForView.email)
        textField.addTarget(self, action: #selector(textFieldsIsEmptyCheck), for: .editingChanged)
        return textField
    }()
    // PasswordTextField
    private lazy var passwordTextField: UITextField = {
        let textField = LoginDisplayTextField(placeholdere: KeysForView.password)
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldsIsEmptyCheck), for: .editingChanged)
        return textField
    }()
    // MARK: Buttons
    // Support button
    private let supportButton = OneImageButton(image: UIImage(named: KeysForImage.questionFigma) ?? UIImage())
    // Change lang button
    private let setLangButton = OneImageButton(image: UIImage(named: KeysForImage.netFigma) ?? UIImage())
    // Login button
    private let loginButton = ConfirmButton(titleButton: KeysForView.login, colorButton: .white, fontButton: .jostMedium18(), textColorButton: .tintsOfBlack, buttonImage: UIImage(), typeButton: .system)
    // Reset password button
    private let resetPassButton = OneImageButton(image: UIImage(named: KeysForImage.resetPassword) ?? UIImage())
    // Registration button
    private let registrationButton: UIButton = {
        let button = OneImageButton(image: UIImage(named: KeysForImage.registrationButton) ?? UIImage())
        button.addTarget(self, action: #selector(pushRegistration), for: .touchUpInside)
        return button
    }()
    // MARK: Views
    // Conteiner view
    let conteinerView = HeaderView()
    // Fill color between self.view top and safeArea top
    private let purposeTopFillView = PurpouseTopFillView()
    // Top header view
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purpoureMidnight
        return view
    }()
    // Logo Image View
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: KeysForImage.appLogoButton)
        view.contentMode = .scaleAspectFit
        return view
    }()
    //MARK: System methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginPageModel.loadDate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        constraints()
        addTapGestureToHideKeyboard()
        loginPageModel.dateDelegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginPageModel.timer?.invalidate()
    }
    // MARK: Custom funcs
    private func addView() {
        view.addSubview(conteinerView)
        view.addSubview(registrationButton)
        conteinerView.addSubview(headerView)
        conteinerView.addSubview(purposeTopFillView)
        conteinerView.addSubview(logoImageView)
        conteinerView.addSubview(timeLabel)
        conteinerView.addSubview(dateLabel)
        conteinerView.addSubview(emailTextField)
        conteinerView.addSubview(passwordTextField)
        conteinerView.addSubview(loginButton)
        conteinerView.addSubview(resetPassButton)
        headerView.addSubview(supportButton)
        headerView.addSubview(supportLabel)
        headerView.addSubview(setLangButton)
        headerView.addSubview(didChangeLangLabel)
    }
}
// MARK: Constraints
private extension LoginScreenVc {
    func constraints() {
        NSLayoutConstraint.activate([
            // Conteiner view
            conteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.inset58),
            //Header View
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: LayoutConstants.height58),
            // Fill Header (for hide base view color)
            purposeTopFillView.topAnchor.constraint(equalTo: view.topAnchor),
            purposeTopFillView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            purposeTopFillView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            // Support Button
            supportButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: LayoutConstants.inset17),
            supportButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            supportButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width20),
            supportButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height20),
            // Support label
            supportLabel.leadingAnchor.constraint(equalTo: supportButton.trailingAnchor, constant: LayoutConstants.inset8),
            supportLabel.centerYAnchor.constraint(equalTo: supportButton.centerYAnchor),
            // Set Language Button
            setLangButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            setLangButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -LayoutConstants.inset16),
            setLangButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width20),
            setLangButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height20),
            // Did Changed Lang Label
            didChangeLangLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            didChangeLangLabel.trailingAnchor.constraint(equalTo: setLangButton.leadingAnchor, constant: -LayoutConstants.inset8),
            didChangeLangLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.width20),
            didChangeLangLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height20),
            // Logo Image View
            logoImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: LayoutConstants.inset30),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.width151),
            logoImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.height151),
            // Time Label
            timeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: LayoutConstants.inset8),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.width143),
            timeLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height72),
            // Date label
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.width87),
            dateLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height20),
            // Email text field
            emailTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: LayoutConstants.inset3),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset72),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset72),
            emailTextField.heightAnchor.constraint(equalToConstant: LayoutConstants.inset48),
            // Password text field
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: LayoutConstants.inset0),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset72),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset72),
            passwordTextField.heightAnchor.constraint(equalToConstant: LayoutConstants.height48),
            // Login Button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: LayoutConstants.inset23),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset72),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset72),
            loginButton.heightAnchor.constraint(equalToConstant: LayoutConstants.inset50),
            // Reset password label
            resetPassButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: LayoutConstants.inset20),
            resetPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: LayoutConstants.inset11),
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: LayoutConstants.inset11)
        ])
    }
}
// MARK: Actions
private extension LoginScreenVc {
    // Push to registrationVc
    @objc func pushRegistration() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = RegistrationVc()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    // Check text fields
    @objc func textFieldsIsEmptyCheck() {
        let isEmpty = (emailTextField.text?.isEmpty ?? true) || (passwordTextField.text?.isEmpty ?? true)
        if !isEmpty {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
}
// MARK: Delegate for time and date
extension LoginScreenVc: GiveAwayDateProtocol {
    func giveAwayTime(time: String) {
        DispatchQueue.main.async {
            self.timeLabel.text = time
        }
    }
    func giveAwayDate(date: String) {
        DispatchQueue.main.async {
            self.dateLabel.text = date
        }
    }
}
