//
//  RegistrationVc.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 18.11.22.
//

import UIKit

final class RegistrationVc: UIViewController {
    // MARK: Model
    private let registrationModel: RegistrationModelProtocol = RegistrationModel()
   
    // MARK: Percent height disp which taken header view
    private let percentHeightTaken = 0.38
    // MARK: Labels
    private let inregistrareLabel = HeaderLabel(text: KeysForView.inregistrare)
    private let nameLabel = RegistrationTfLabel(titleText: KeysForView.name, redStar: KeysForSymbols.star)
    private let preNameLabel = RegistrationTfLabel(titleText: KeysForView.preNume, redStar: KeysForSymbols.star)
    private let sexulLabel = RegistrationTfLabel(titleText: KeysForView.sex, redStar: KeysForSymbols.star)
    private let dateOfBirthLabel = RegistrationTfLabel(titleText: KeysForView.dateOfBirth, redStar: KeysForSymbols.star)
    private let emailLabel = RegistrationTfLabel(titleText: KeysForView.email, redStar: KeysForSymbols.star)
    private let passwordLabel = RegistrationTfLabel(titleText: KeysForView.password, redStar: KeysForSymbols.star)
    private let adressLabel = RegistrationTfLabel(titleText: KeysForView.adress, redStar: KeysForSymbols.star)
    private let professionLabel = RegistrationTfLabel(titleText: KeysForView.proffesion, redStar: "")
    // Password rules
    let passwordRulesLabel = UniversalLabel(titleText: KeysForView.passwordRules, color: .eerieBlackAlpha50, labelFont: .jostRegular14() ?? UIFont())
    // Personal Checkbox label
    private let personalLabel = UniversalLabel(titleText: KeysForView.hearingImpairedPerson, color: .black, labelFont: UIFont.jostRegular16() ?? UIFont())
    
    // Agreenment Checkbox Label
    private let agreenementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        let attstroke = NSMutableAttributedString(string: KeysForView.checkBoxAgreement)
        attstroke.addAttributes([.foregroundColor : UIColor.black], range: NSRange(location: 0, length: 16))
        attstroke.addAttributes([.foregroundColor : UIColor.purpoureLight,
                                 .underlineColor : UIColor.purpoureLight,
                                 .underlineStyle : NSUnderlineStyle.single.rawValue], range: NSRange(location: 17, length: 22))
        attstroke.addAttributes([.foregroundColor : UIColor.black], range: NSRange(location: 39, length: 10))
        label.font = UIFont.jostRegular16()
        label.textAlignment = .left
        label.attributedText = attstroke
        return label
    }()
    // Change lang label (under separatop)
    private let changeLanguageLabel = UniversalLabel(titleText: KeysForView.changeLanguage, color: .black, labelFont: UIFont.jostMedium20() ?? UIFont())
    // Radio label
    private let romanianLangLabel = UniversalLabel(titleText: KeysForView.romanian, color: .black, labelFont: UIFont.jostRegular17() ?? UIFont())
    // Radio label
    private let russianLangLabel = UniversalLabel(titleText: KeysForView.russion, color: .black, labelFont: .jostRegular17() ?? UIFont())
    // MARK: TextFields
    private let nameTextField: RegistrationTextField = {
        let textField = RegistrationTextField(placeholdere: "")
        textField.addTarget(self, action: #selector(enteredFormatTf(sender:)), for: .editingChanged)
        return textField
    }()
    private let preNameTf: RegistrationTextField = {
        let textField = RegistrationTextField(placeholdere: "")
        textField.addTarget(self, action: #selector(enteredFormatTf(sender:)), for: .editingChanged)
        return textField
    }()
    private let sexulTf = RegistrationTextField(placeholdere: KeysForView.changed)
    private let dateOfBirthTf: UITextField = {
        let textField = RegistrationTextField(placeholdere: KeysForView.dateFormat)
        return textField
    }()
    private let emailTf = RegistrationTextField(placeholdere: KeysForView.emailExample)
    private let passwordTf: RegistrationTextField = {
        let textField = RegistrationTextField(placeholdere: KeysForView.passwordExample)
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        return textField
    }()
    private let adressTf = RegistrationTextField(placeholdere: "")
    private let professionTf = RegistrationTextField(placeholdere: "")
    private let hearingImpaireTf: UITextField = {
        let textField = RegistrationTextField(placeholdere: KeysForView.specifyTheDegree)
        textField.isHidden = true
        return textField
    }()
    // MARK: Buttons
    // Back Button Item
    private let backButtonItem: BackButtonItem = {
        let button = BackButtonItem()
        button.addTarget(self, action: #selector(popVc), for: .touchUpInside)
        return button
    }()
    // hearing degree checkBox Button
    let personalCheckbox: CheckboxButton = {
        let button = CheckboxButton()
        button.addTarget(self, action: #selector(activateHearingDegreePunct(sender:)), for: .touchUpInside)
        return button
    }()
    // Agree app rules checkBox Button
    let agreementCheckbox: CheckboxButton = {
        let button = CheckboxButton()
        button.addTarget(self, action: #selector(agreeToTheTermsCheckBox), for: .touchUpInside)
        return button
    }()
    // romanion lang radio button
    let romanianLangButton: RadioButton = {
        let button = RadioButton()
        button.isSelected = true
        button.addTarget(self, action: #selector(toggleRadioButtonSelection(sender:)), for: .touchUpInside)
        return button
    }()
    // russion lang radio button
    let russianLangButton: RadioButton = {
        let button = RadioButton()
        button.addTarget(self, action: #selector(toggleRadioButtonSelection(sender:)), for: .touchUpInside)
        return button
    }()
    // Inregistrate button
    private let registrateButton: UIButton  = {
        let button = ConfirmButton(titleButton: "??nregistrare", colorButton: .purpoureLight, fontButton: .jostMedium18(), textColorButton: .white, buttonImage: UIImage(named: KeysForImage.rightArrowFigma), typeButton: .system)
        button.addTarget(self, action: #selector(registrationAction), for: .touchUpInside)
        return button
    }()
    //Chevron down on sex text field
    private let downArrowButton = OneImageButton(image: UIImage(named: KeysForImage.downArrowFigma) ?? UIImage())
    //Date picker (Date of birth TF)
    private lazy var dateOfBirthButton = OneImageButton(image: UIImage(named: KeysForImage.datePickerFigma) ?? UIImage())
    // MARK: Views
    // Header
    private lazy var headerView = HeaderView()
    // ClearView
    private let clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // ScroolView
    private lazy var scrollView = UIScrollView()
    // ContainerView
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = LayoutConstants.inset20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()
    // Picker view change your sex
    private lazy var changeYourSexPicker: UIPickerView = {
        let picker = UIPickerView()
        self.sexulTf.inputView = picker
        return picker
}()
    // Picker view change hearing degree
    private lazy var hearingImpairePicker: UIPickerView = {
        let picker = UIPickerView()
        self.hearingImpaireTf.inputView = picker
        return picker
    }()
    // Date picker setting
    private func datePickerSet() {
        if #available(iOS 13.4, *) {
            let datePicker = UIDatePicker()
                datePicker.preferredDatePickerStyle = .wheels
                datePicker.datePickerMode = .date
                datePicker.maximumDate = Date()
                datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
                dateOfBirthTf.inputView = datePicker
            }
        }
    // Separator
    private let separatorView = SeparatorView(color: .borderGrayColor)
    // MARK: Basic methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clearView.frame = CGRect(x: LayoutConstants.inset0, y: inregistrareLabel.frame.maxY + LayoutConstants.inset16, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.frame = clearView.bounds
        containerView.frame = CGRect(x: LayoutConstants.inset16, y: LayoutConstants.inset0, width: (UIScreen.main.bounds.width - LayoutConstants.inset32), height: LayoutConstants.height1350)
        scrollView.contentSize = CGSize(width: (UIScreen.main.bounds.width), height: LayoutConstants.height1350)
       
        nameLabel.frame = CGRect(x: LayoutConstants.inset22, y: LayoutConstants.inset16, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height20)
        nameTextField.frame = CGRect(x: LayoutConstants.inset22, y: nameLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Prename
        preNameLabel.frame = CGRect(x: LayoutConstants.inset22, y: nameTextField.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height32)
        preNameTf.frame = CGRect(x: LayoutConstants.inset22, y: preNameLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Sex
        sexulLabel.frame = CGRect(x: LayoutConstants.inset22, y: preNameTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height32)
        sexulTf.frame = CGRect(x: LayoutConstants.inset22, y: sexulLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Birth date
        dateOfBirthLabel.frame = CGRect(x: LayoutConstants.inset22, y: sexulTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height32)
        dateOfBirthTf.frame = CGRect(x: LayoutConstants.inset22, y: dateOfBirthLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Email
        emailLabel.frame = CGRect(x: LayoutConstants.inset22, y: dateOfBirthTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height32)
        emailTf.frame = CGRect(x: LayoutConstants.inset22, y: emailLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Password
        passwordLabel.frame = CGRect(x: LayoutConstants.inset22, y: emailTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height32)
        passwordTf.frame = CGRect(x: LayoutConstants.inset22, y: passwordLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
         // Adress
        adressLabel.frame = CGRect(x: LayoutConstants.inset22, y: passwordRulesLabel.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height32)
        adressTf.frame = CGRect(x: LayoutConstants.inset22, y: adressLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Profession
        professionLabel.frame = CGRect(x: LayoutConstants.inset22, y: adressTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height32)
        professionTf.frame = CGRect(x: LayoutConstants.inset22, y: professionLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Specify the degree textfield
        hearingImpaireTf.frame = CGRect(x: LayoutConstants.inset22, y: personalLabel.frame.maxY + LayoutConstants.inset2, width: (LayoutConstants.displayWidth - LayoutConstants.width76), height: LayoutConstants.height48)
    }
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperView()
        addView()
        constraints()
        datePickerSet()
        toolBarSet()
        addTapGestureToHideKeyboard()
        checkEmailAndPass()
        changeYourSexPicker.delegate = self
        changeYourSexPicker.dataSource = self
        hearingImpairePicker.delegate = self
        hearingImpairePicker.dataSource = self
    }
}
// MARK: Custom Funcs
    private extension RegistrationVc {
    // ToolBar
     func toolBarSet() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexSpace, doneButton], animated: true)
        nameTextField.inputAccessoryView = toolBar
        preNameTf.inputAccessoryView = toolBar
        dateOfBirthTf.inputAccessoryView = toolBar
        sexulTf.inputAccessoryView = toolBar
        emailTf.inputAccessoryView = toolBar
        passwordTf.inputAccessoryView = toolBar
        adressTf.inputAccessoryView = toolBar
        professionTf.inputAccessoryView = toolBar
        hearingImpaireTf.inputAccessoryView = toolBar
    }
    // Check result (email, password)
     func checkEmailAndPass() {
        registrationModel.update = {
            self.pushHomeVc()
        }
        registrationModel.updateError = {
            self.alertMissEmailOrPass()
        }
    }
    // Setup super view
     func setupSuperView() {
        view.backgroundColor = .white
        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor.white.cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        view.addSubview(shapes)
        shapes.layer.cornerRadius = 20
        var shadows = UIView()
        shadows.frame = view.frame
        shadows.clipsToBounds = false
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 20)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor.jacksonsPurpleAlpha21.cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 20
        layer0.shadowOffset = CGSize(width: 0, height: 0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        view.addSubview(shadows)
    }
    // Add view
         func addView() {
            view.addSubview(headerView)
            view.addSubview(clearView)
            headerView.addSubview(inregistrareLabel)
            headerView.addSubview(backButtonItem)
            clearView.addSubview(scrollView)
            scrollView.addSubview(containerView)
            containerView.addSubview(nameLabel)
            containerView.addSubview(nameTextField)
            containerView.addSubview(preNameLabel)
            containerView.addSubview(preNameTf)
            containerView.addSubview(sexulLabel)
            containerView.addSubview(sexulTf)
            containerView.addSubview(dateOfBirthLabel)
            containerView.addSubview(dateOfBirthTf)
            containerView.addSubview(emailLabel)
            containerView.addSubview(emailTf)
            containerView.addSubview(passwordLabel)
            containerView.addSubview(passwordTf)
            containerView.addSubview(passwordRulesLabel)
            containerView.addSubview(adressLabel)
            containerView.addSubview(adressTf)
            containerView.addSubview(professionLabel)
            containerView.addSubview(professionTf)
            containerView.addSubview(personalCheckbox)
            containerView.addSubview(agreementCheckbox)
            containerView.addSubview(personalLabel)
            containerView.addSubview(agreenementLabel)
            containerView.addSubview(separatorView)
            containerView.addSubview(changeLanguageLabel)
            containerView.addSubview(romanianLangButton)
            containerView.addSubview(russianLangButton)
            containerView.addSubview(russianLangLabel)
            containerView.addSubview(romanianLangLabel)
            containerView.addSubview(registrateButton)
            containerView.addSubview(hearingImpaireTf)
            sexulTf.addSubview(downArrowButton)
            dateOfBirthTf.addSubview(dateOfBirthButton)
        }
    }

// MARK: Actions
private extension RegistrationVc {
    // Activate hearind degree textField
    @objc func activateHearingDegreePunct(sender: UIButton) {
        sender.isSelected ? (hearingImpaireTf.isHidden = false) : (hearingImpaireTf.isHidden = true)
    }
    // Input limits for Text Field
    @objc func enteredFormatTf(sender: UITextField) {
        guard let text = sender.text?.lowercased() else { return }
        let engCharacters = "qwertyuiopasdfghjklzxcvbnm"
        text.forEach { (char) in
            if !engCharacters.contains(char)  {
                sender.text?.remove(at: text.firstIndex(of: char)!)
            }
        }
    }
    // TF is empty? (red bordered)
    @objc private func checkTextField() -> Bool {
        var textFieldArray = [nameTextField, preNameTf, sexulTf, dateOfBirthTf, emailTf, passwordTf, adressTf]
        personalCheckbox.isSelected ? (textFieldArray.append(hearingImpaireTf)) : print("")
        lazy var result: Bool = true
        textFieldArray.forEach({ [ weak self ] textField in
            guard let self = self else { return }
            if textField.text?.isEmpty ?? true {
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
                result = false }
        })
        return result
    }
    // If user agree rules - regButton will stand active
    @objc private func agreeToTheTermsCheckBox() {
        agreementCheckbox.isSelected ? (registrateButton.isEnabled = true) : (registrateButton.isEnabled = false)
        constraints()
    }
    // Action done for tool bar button
    @objc private func doneAction() {
        view.endEditing(true)
    }
    // Func for add date in Text field date of birth
    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "dd.MM.yyyy"
        dateOfBirthTf.text = dateFomatter.string(from: sender.date)
    }
    // Push Home Screen Vc
    @objc private func pushHomeVc() {
        let nextVc = HomeScreenVc()
        navigationController?.pushViewController(nextVc, animated: true)
    }
    // Action pop vc
    @objc private func popVc() {
        navigationController?.popViewController(animated: true)
    }
    // Radio action (Change language)
    @objc private func toggleRadioButtonSelection(sender: RadioButton) {
        switch sender {
        case romanianLangButton:
            romanianLangButton.isSelected = true
            russianLangButton.isSelected = false
        case russianLangButton:
            russianLangButton.isSelected = true
            romanianLangButton.isSelected = false
        default:
            break
        }
    }
    // Action for registration button (Checking email and password correct)
        @objc private func registrationAction() {
           let isResult = checkTextField()
            isResult ? registrationModel.checkEmailAndPassword(email: emailTf.text, password: passwordTf.text) : self.emptyFields()
        }
}
// MARK: ALERTs
private extension RegistrationVc {
    // Alert if email or pass missing
    private func alertMissEmailOrPass() {
        let alert = UIAlertController(title: KeysForView.checkYourEmailAndPass, message: KeysForView.stepForEmailPassCheck , preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(button)
        present(alert, animated: true)
    }
    // Alert fill Red Fields
    private func emptyFields() {
        let alert = UIAlertController(title: KeysForView.fillRedFields, message: "" , preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(button)
        present(alert, animated: true)
    }
}
// MARK: Constraint Extension
private extension RegistrationVc {
    func constraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -LayoutConstants.inset8),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LayoutConstants.inset8),
            headerView.heightAnchor.constraint(equalToConstant: (LayoutConstants.displayHeight * percentHeightTaken)),
            // Inregistrare Label.widthAnchor.constraint(equalToConstant: LayoutConstants.width131),
            backButtonItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.inset24),
            backButtonItem.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: LayoutConstants.inset16),
            backButtonItem.widthAnchor.constraint(equalToConstant: LayoutConstants.width25),
            backButtonItem.heightAnchor.constraint(equalToConstant: LayoutConstants.height13),
            //            // Inregistrare Label
            inregistrareLabel.topAnchor.constraint(equalTo: backButtonItem.bottomAnchor, constant: LayoutConstants.inset10),
            inregistrareLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            inregistrareLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height38),
            // Personale label
            personalLabel.topAnchor.constraint(equalTo: professionTf.bottomAnchor, constant: LayoutConstants.inset28),
            personalLabel.leadingAnchor.constraint(equalTo: personalCheckbox.trailingAnchor, constant: LayoutConstants.inset10),
            personalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.inset72),
            // Personal checkbox
            personalCheckbox.topAnchor.constraint(equalTo: personalLabel.topAnchor),
            personalCheckbox.leadingAnchor.constraint(equalTo: professionTf.leadingAnchor),
            personalCheckbox.widthAnchor.constraint(equalToConstant: LayoutConstants.width22),
            personalCheckbox.heightAnchor.constraint(equalToConstant: LayoutConstants.height22),
            agreenementLabel.topAnchor.constraint(equalTo: personalLabel.bottomAnchor, constant: LayoutConstants.inset55),
            agreenementLabel.leadingAnchor.constraint(equalTo: personalLabel.leadingAnchor),
            agreenementLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.inset72),
            // Agreenement Checkbox
            agreementCheckbox.topAnchor.constraint(equalTo: agreenementLabel.topAnchor),
            agreementCheckbox.leadingAnchor.constraint(equalTo: personalCheckbox.leadingAnchor),
            agreementCheckbox.widthAnchor.constraint(equalToConstant: LayoutConstants.width22),
            agreementCheckbox.heightAnchor.constraint(equalToConstant: LayoutConstants.height22),
            // Separator
            separatorView.topAnchor.constraint(equalTo: agreenementLabel.bottomAnchor, constant: LayoutConstants.inset30),
            separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.inset30),
            separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.inset30),
            separatorView.heightAnchor.constraint(equalToConstant: LayoutConstants.height1),
            // Change lang label
            changeLanguageLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: LayoutConstants.inset6),
            changeLanguageLabel.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor),
            // Romanian lang button
            romanianLangButton.leadingAnchor.constraint(equalTo: changeLanguageLabel.leadingAnchor),
            romanianLangButton.topAnchor.constraint(equalTo: changeLanguageLabel.bottomAnchor, constant: LayoutConstants.inset4),
            romanianLangButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width22),
            romanianLangButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height22),
            // Romanian lang label
            romanianLangLabel.centerYAnchor.constraint(equalTo: romanianLangButton.centerYAnchor),
            romanianLangLabel.leadingAnchor.constraint(equalTo: romanianLangButton.trailingAnchor, constant: LayoutConstants.inset10),
            romanianLangLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.width82),
            // russion lang button
            russianLangButton.centerYAnchor.constraint(equalTo: romanianLangButton.centerYAnchor),
            russianLangButton.leadingAnchor.constraint(equalTo: romanianLangLabel.trailingAnchor, constant: LayoutConstants.inset30),
            russianLangButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width22),
            russianLangButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height22),
            // russion lang button
            russianLangLabel.centerYAnchor.constraint(equalTo: russianLangButton.centerYAnchor),
            russianLangLabel.leadingAnchor.constraint(equalTo: russianLangButton.trailingAnchor, constant: LayoutConstants.inset10),
            russianLangLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.width82),
            //
            registrateButton.topAnchor.constraint(equalTo: russianLangLabel.bottomAnchor, constant: LayoutConstants.inset50),
            // registrateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrateButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.inset30),
            registrateButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.inset30),
            registrateButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height50),
            downArrowButton.centerYAnchor.constraint(equalTo: sexulTf.centerYAnchor),
            downArrowButton.trailingAnchor.constraint(equalTo: sexulTf.trailingAnchor, constant: -LayoutConstants.inset20),
            // DatePicker button on BirthTF
            dateOfBirthButton.centerYAnchor.constraint(equalTo: dateOfBirthTf.centerYAnchor),
            dateOfBirthButton.trailingAnchor.constraint(equalTo: dateOfBirthTf.trailingAnchor, constant: -LayoutConstants.inset20),
            dateOfBirthButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height15),
            dateOfBirthButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width15),
            // Arrow right (on "sent form" button)
            passwordRulesLabel.topAnchor.constraint(equalTo: passwordTf.bottomAnchor, constant: LayoutConstants.inset1),
            passwordRulesLabel.leadingAnchor.constraint(equalTo: passwordTf.leadingAnchor),
            passwordRulesLabel.trailingAnchor.constraint(equalTo: passwordTf.trailingAnchor),
        ])
    }
}
// MARK: Delegate and Data Source for Picker view
extension RegistrationVc: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Int(LayoutConstants.inset1)
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case changeYourSexPicker:
            return registrationModel.sexArray.count
        case hearingImpairePicker:
            return registrationModel.degreeSpecifyArray.count
        default: break
        }
        return Int(LayoutConstants.inset0)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case changeYourSexPicker:
            return registrationModel.sexArray[row]
        case hearingImpairePicker:
            return registrationModel.degreeSpecifyArray[row]
        default: break
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case changeYourSexPicker:
            self.sexulTf.text = self.registrationModel.sexArray[row]
        case hearingImpairePicker:
            self.hearingImpaireTf.text = self.registrationModel.degreeSpecifyArray[row]
        default: break
        }
    }
}



    

