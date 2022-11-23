//
//  ViewController.swift
//  DeafInfoCenter
//
//  Created by Alinser Shchurko on 16.11.22.
//

import UIKit
import Foundation

class LoginPageVc: UIViewController {
    private let loginPageModel: LoginPageModelProtocol = LoginPageVm()
    
    let conteinerView = OneCornerRadiusView()
    // MARK: Fill color between self.view top and safeArea top
    private let purposeTopFillView = PurpouseTopFillView()
    // MARK: TOP HEADER VIEW
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purpoureMidnight
        return view
    }()
    // MARK: Support Button
    private let supportButton = BasicImageButton(image: UIImage(named: KeysForImage.questionFigma) ?? UIImage())
    private let setLangButton = BasicImageButton(image: UIImage(named: KeysForImage.netFigma) ?? UIImage())
    // MARK: Support label
    private let supportLabel = SecondaryLabel(titleText: KeysForView.support, color: .whiteWithAlpha40, labelFont: .jostRegular15() ?? UIFont())
    private let didChangeLangLabel = SecondaryLabel(titleText: KeysForView.shortLangRu, color: .whiteWithAlpha40, labelFont: .jostRegular15() ?? UIFont())
    // MARK: Logo Image View
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: KeysForImage.appLogoButton)
        view.contentMode = .scaleAspectFit
        return view
    }()
    // MARK: Time Label
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .jostRegular50()
        self.loginPageModel.updateTime = { [ self ] in timeLabel.text = loginPageModel.time }
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = .jostRegular14()
        self.loginPageModel.updateDate = { [ self ] in dateLabel.text = loginPageModel.date }
        return label
    }()
    // MARK: EmailTextField
    private lazy var emailTextField = LoginDisplayTextField(placeholdere: KeysForView.email)
    // MARK: PasswordTextField
    private lazy var passwordTextField: UITextField = {
       let textField = LoginDisplayTextField(placeholdere: KeysForView.password)
        textField.isSecureTextEntry = true
        return textField
    }()
    // MARK: Login Button
    private let loginButton = ConfirmButton(titleButton: KeysForView.login, colorButton: .white, fontButton: .jostMedium18(), textColorButton: .tintsOfBlack, buttonImage: UIImage(), typeButton: .system)

    // MARK: Reset password button
    private let resetPassButton = BasicImageButton(image: UIImage(named: KeysForImage.resetPassword) ?? UIImage())
    private let registrationButton: UIButton = {
      let button = BasicImageButton(image: UIImage(named: KeysForImage.registrationButton) ?? UIImage())
        button.addTarget(self, action: #selector(transitionTo), for: .touchUpInside)
        return button
    }()
    @objc func transitionTo() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let nextVC = RegistrationVc()
         navigationController?.pushViewController(nextVC, animated: true)
    }
    //MARK: Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    //MARK: Start func for showed time
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginPageModel.loadDate()
    }
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        constraints()
    }
    // MARK: Stop timer
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loginPageModel.timer?.invalidate()
    }
// MARK: Add view button
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

    private func constraints() {
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


