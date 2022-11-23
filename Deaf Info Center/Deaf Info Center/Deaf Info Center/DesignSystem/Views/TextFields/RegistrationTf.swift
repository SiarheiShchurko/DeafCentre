//
//  RegistrationTf.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 20.11.22.
//

import UIKit

final class RegistrationTextField: UITextField {
    init() {
        super.init(frame: .zero)
        setTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let separatorView: UIView = {
       let view = UIView()
        view.frame = CGRect(x: LayoutConstants.inset0, y: LayoutConstants.inset46, width: (LayoutConstants.displayWidth - LayoutConstants.width76 ), height: LayoutConstants.inset1)
        view.backgroundColor = .gray
        return view
    }()
}

private extension RegistrationTextField {
    private func setTextField() {
        self.textColor = .eerieBlack
        self.font = .jostRegular20()
        self.textAlignment = .left
        self.addSubview(separatorView)
        self.layer.backgroundColor = UIColor.jacksonsPurpleAlpha21.cgColor
    }
}
