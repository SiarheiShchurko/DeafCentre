//
//  RegistrationDispTF.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 17.11.22.
//

import UIKit

final class LoginDisplayTextField: UITextField {
    var placeholdere: String?
    init(placeholdere: String) {
        self.placeholdere = placeholdere
        super.init(frame: .zero)
        setTextField(placeholder: placeholdere)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let separatorView: UIView = {
       let view = UIView()
        view.frame = CGRect(x: LayoutConstants.inset0, y: LayoutConstants.inset46, width: (UIScreen.main.bounds.width - LayoutConstants.inset144), height: LayoutConstants.inset1)
        view.backgroundColor = .whiteWithAlpha20
        return view
    }()
}

private extension LoginDisplayTextField {
    private func setTextField(placeholder: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.whiteWithAlpha40])
        self.textColor = .white
        self.font = .jostRegular15()
        self.textAlignment = .left
        self.addSubview(separatorView)
        
    }
}
