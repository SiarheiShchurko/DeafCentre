//
//  UIView + Extension.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 23.11.22.
//

import UIKit

extension UIView {
    // MARK: Extension for hideKeyboard
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    var topSuperview: UIView? {
        var view = superview
        while view?.superview != nil {
            view = view!.superview
        }
        return view
    }
    @objc func dismissKeyboard() {
        topSuperview?.endEditing(true)
    }
    func addShadows() {
        self.backgroundColor = .white
        var shapes = UIView()
        shapes.frame = CGRect(x: (self.frame.minX + LayoutConstants.inset8), y: self.frame.minY, width: (LayoutConstants.displayWidth - LayoutConstants.inset16), height: LayoutConstants.displayHeight)
        shapes.clipsToBounds = true
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor.white.cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        self.addSubview(shapes)
        shapes.layer.cornerRadius = LayoutConstants.inset20
        var shadows = UIView()
        shadows.frame = shapes.bounds
        shadows.clipsToBounds = false
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: LayoutConstants.inset20)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor.jacksonsPurpleAlpha21.cgColor
        layer0.shadowOpacity = Float(LayoutConstants.inset1)
        layer0.shadowRadius = LayoutConstants.inset20
        layer0.shadowOffset = CGSize(width: LayoutConstants.width0, height: LayoutConstants.height0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        self.addSubview(shadows)
    }
}
