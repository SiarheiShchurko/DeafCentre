//
//  UITextField + extension.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 25.11.22.
//

import UIKit
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - LayoutConstants.inset1, width: self.frame.size.width, height: LayoutConstants.height1)
        bottomLine.backgroundColor = UIColor.red.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}
