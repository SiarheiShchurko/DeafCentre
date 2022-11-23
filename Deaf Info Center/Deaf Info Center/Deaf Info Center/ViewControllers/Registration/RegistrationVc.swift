//
//  RegistrationVc.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 18.11.22.
//

import UIKit

final class RegistrationVc: UIViewController {
    // MARK: Model
    private let registrationModel: GetRegistrationModelProtocol = RegistrationModel()
    
    // MARK: HeaderView
    private lazy var headerView = OneCornerRadiusView()

    // MARK: Percent height disp which taken header view
    private let percentHeightTaken = 0.38
    // MARK: ClearView
    private let clearView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    // MARK: ScroolView
    private lazy var scrollView = UIScrollView()
    // MARK: ContainerView
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = LayoutConstants.inset20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()
    

//    private lazy var stackView: UIStackView = {
//       let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField, preNameLabel, preNameTf, sexulLabel, sexulTf, dateOfBirthLabel, dateOfBirthTf, emailLabel, emailTf, passwordLabel, passwordTf, adressLabel, adressTf, professionLabel, professionTf])
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.spacing = LayoutConstants.inset16
//        stackView.
//        stackView.frame.size = CGSize(width: containerView.frame.width - LayoutConstants.width76, height: max(nameLabel.frame.size.height, nameTextField.frame.size.height, preNameLabel.frame.size.height, preNameTf.frame.size.height, sexulLabel.frame.size.height, sexulTf.frame.size.height, dateOfBirthLabel.frame.size.height, dateOfBirthTf.frame.size.height, emailLabel.frame.size.height, emailTf.frame.size.height, passwordLabel.frame.size.height, passwordTf.frame.size.height, adressLabel.frame.size.height, adressTf.frame.size.height, professionLabel.frame.size.height, professionTf.frame.size.height))
//        return stackView
//    }()
    // MARK: Inregistrare label (on header view)
    private let inregistrareLabel = HeaderLabel(text: KeysForView.inregistrare)
    
    // MARK: Labels for registration
    private let nameLabel = RegistrationTfLabel(titleText: KeysForView.name, redStar: KeysForSymbols.star)
    private let preNameLabel = RegistrationTfLabel(titleText: KeysForView.preNume, redStar: KeysForSymbols.star)
    private let sexulLabel = RegistrationTfLabel(titleText: KeysForView.sex, redStar: KeysForSymbols.star)
    private let dateOfBirthLabel = RegistrationTfLabel(titleText: KeysForView.dateOfBirth, redStar: KeysForSymbols.star)
    private let emailLabel = RegistrationTfLabel(titleText: KeysForView.email, redStar: KeysForSymbols.star)
    private let passwordLabel = RegistrationTfLabel(titleText: KeysForView.password, redStar: KeysForSymbols.star)
    private let adressLabel = RegistrationTfLabel(titleText: KeysForView.adress, redStar: KeysForSymbols.star)
    private let professionLabel = RegistrationTfLabel(titleText: KeysForView.proffesion, redStar: "")
    
    //MARK: Checkbox Labels
    // Personal Checkbox label
    private let personalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = KeysForView.checkBoxPersonal
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.jostRegular16()
        return label
    }()
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
    private let changeLanguageLabel = SecondaryLabel(titleText: KeysForView.changeLanguage, color: .black, labelFont: UIFont.jostMedium20() ?? UIFont())
        // Radio label
        private let romanianLangLabel = SecondaryLabel(titleText: KeysForView.romanian, color: .black, labelFont: UIFont.jostRegular17() ?? UIFont())
        // Radio label
        private let russianLangLabel = SecondaryLabel(titleText: KeysForView.russion, color: .black, labelFont: .jostRegular17() ?? UIFont())


    // MARK: TextFields for registration
    private let nameTextField: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    private let preNameTf: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    private let sexulTf: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.attributedPlaceholder = NSAttributedString(string: KeysForView.changed,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.eerieBlackAlpha50])
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    private let dateOfBirthTf: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    private let emailTf: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    private let passwordTf: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    private let adressTf: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    private let professionTf: RegistrationTextField = {
        let textField = RegistrationTextField()
        textField.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return textField
    }()
    // MARK: Buttons
    // Back Button Item
    private let backButtonItem: BackButtonItem = {
      let button = BackButtonItem()
        button.addTarget(self, action: #selector(popVc), for: .touchUpInside)
        return button
    }()
    // personal checkBox Button
    let personalCheckbox: CheckboxButton = {
        let button = CheckboxButton()
        button.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
        return button
    }()
    // agree checkBox Button
    let agreementCheckbox: CheckboxButton = {
        let button = CheckboxButton()
        button.addTarget(self, action: #selector(checkTextField), for: .touchUpInside)
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
    
    private let registrateButton = ConfirmButton(titleButton: "Înregistrare", colorButton: .purpoureLight, fontButton: .jostMedium18(), textColorButton: .white, buttonImage: UIImage(named: KeysForImage.rightArrowFigma), typeButton: .system)

    //Arrow down on sex text field
    private let downArrowButton = BasicImageButton(image: UIImage(named: KeysForImage.downArrowFigma) ?? UIImage())
    //Date picker (Date of birth TF)
    private lazy var dateOfBirthButton: UIButton = {
        let button = BasicImageButton(image: UIImage(named: KeysForImage.datePickerFigma) ?? UIImage())
        return button
    }()
    // Arrow on sentFormButton
    private let arrowSentFormButton = BasicImageButton(image: UIImage(named: KeysForImage.rightArrowFigma) ?? UIImage())
    // Picker view change your sex
    private func changeYourSex() {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        sexulTf.inputView = picker
    }
    // Date picker setting
    private func datePickerSet() {
        if #available(iOS 13.4, *) {
            let datePicker = UIDatePicker()
                datePicker.preferredDatePickerStyle = .wheels
                datePicker.datePickerMode = .date
                datePicker.maximumDate = Date()
                datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
                dateOfBirthTf.inputView = datePicker
            } else {
                print("")
        }
    }
    //MARK: Separator
    private let separatorView = SeparatorView(color: .borderGrayColor)
    // MARK: Action
    // TF is empty?
    @objc private func checkTextField() {
        let isEmpty = (nameTextField.text?.isEmpty ?? true) || (preNameTf.text?.isEmpty ?? true) || (sexulTf.text?.isEmpty ?? true) || (dateOfBirthTf.text?.isEmpty ?? true) || (emailTf.text?.isEmpty ?? true) || (passwordTf.text?.isEmpty ?? true) || (adressTf.text?.isEmpty ?? true)

           if personalCheckbox.isSelected,
              agreementCheckbox.isSelected,
              !isEmpty {
              registrateButton.isEnabled = true
        }
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
    // MARK: Funcs
    // ToolBar
    private func toolBarSet() {
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
    }
    // Setup super view
    private func setupSuperView() {
        view.backgroundColor = .white
        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
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
        layer0.shadowColor = UIColor(red: 0.259, green: 0.263, blue: 0.525, alpha: 0.2).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 20
        layer0.shadowOffset = CGSize(width: 0, height: 0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        view.addSubview(shadows)
    }
    
    // Add view
    private func addView() {
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
        sexulTf.addSubview(downArrowButton)
        dateOfBirthTf.addSubview(dateOfBirthButton)
      //  registrateButton.addSubview(arrowSentFormButton)
    }
    // MARK: Basic methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clearView.frame = CGRect(x: LayoutConstants.inset0, y: inregistrareLabel.frame.maxY + LayoutConstants.inset16, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.frame = clearView.bounds
        containerView.frame = CGRect(x: LayoutConstants.inset16, y: LayoutConstants.inset0, width: (UIScreen.main.bounds.width - LayoutConstants.inset32), height: LayoutConstants.height1400)
        scrollView.contentSize = CGSize(width: (UIScreen.main.bounds.width), height: LayoutConstants.height1400)
        // Name
        nameLabel.frame = CGRect(x: LayoutConstants.inset22, y: LayoutConstants.inset16, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        nameTextField.frame = CGRect(x: LayoutConstants.inset22, y: nameLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Prename
        preNameLabel.frame = CGRect(x: LayoutConstants.inset22, y: nameTextField.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        preNameTf.frame = CGRect(x: LayoutConstants.inset22, y: preNameLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Sex
        sexulLabel.frame = CGRect(x: LayoutConstants.inset22, y: preNameTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        sexulTf.frame = CGRect(x: LayoutConstants.inset22, y: sexulLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Birth date
        dateOfBirthLabel.frame = CGRect(x: LayoutConstants.inset22, y: sexulTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        dateOfBirthTf.frame = CGRect(x: LayoutConstants.inset22, y: dateOfBirthLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Email
        emailLabel.frame = CGRect(x: LayoutConstants.inset22, y: dateOfBirthTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        emailTf.frame = CGRect(x: LayoutConstants.inset22, y: emailLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Password
        passwordLabel.frame = CGRect(x: LayoutConstants.inset22, y: emailTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        passwordTf.frame = CGRect(x: LayoutConstants.inset22, y: passwordLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
         // Adress
        adressLabel.frame = CGRect(x: LayoutConstants.inset22, y: passwordTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        adressTf.frame = CGRect(x: LayoutConstants.inset22, y: adressLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
        // Profession
        professionLabel.frame = CGRect(x: LayoutConstants.inset22, y: adressTf.frame.maxY + LayoutConstants.inset8, width: (LayoutConstants.displayWidth - LayoutConstants.width44), height: LayoutConstants.height48)
        professionTf.frame = CGRect(x: LayoutConstants.inset22, y: professionLabel.frame.maxY + LayoutConstants.inset1, width: LayoutConstants.displayWidth - LayoutConstants.width76 , height: LayoutConstants.height48)
    }
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperView()
        addView()
        constraints()
        datePickerSet()
        changeYourSex()
        toolBarSet()
        addTapGestureToHideKeyboard()
    }
    // MARK: Constraints
    private func constraints() {
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
            // Agreenement label
            agreenementLabel.topAnchor.constraint(equalTo: personalCheckbox.bottomAnchor, constant: LayoutConstants.inset40),
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
            arrowSentFormButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height6),
            arrowSentFormButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width12),
            // DatePicker button on BirthTF
            dateOfBirthButton.centerYAnchor.constraint(equalTo: dateOfBirthTf.centerYAnchor),
            dateOfBirthButton.trailingAnchor.constraint(equalTo: dateOfBirthTf.trailingAnchor, constant: -LayoutConstants.inset20),
            dateOfBirthButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height15),
            dateOfBirthButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width15),
            // Arrow right (on "sent form" button)
//            arrowSentFormButton.centerYAnchor.constraint(equalTo: registrateButton.centerYAnchor),
//            arrowSentFormButton.trailingAnchor.constraint(equalTo: registrateButton.trailingAnchor, constant: -LayoutConstants.inset20),
//            arrowSentFormButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height10),
//            arrowSentFormButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width18)
        ])
    }
}

// MARK: Extension
// Delegate and Data Source for Picker view
extension RegistrationVc: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Int(LayoutConstants.inset1)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        registrationModel.sexArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return registrationModel.sexArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.sexulTf.text = self.registrationModel.sexArray[row]
    }
}


    

