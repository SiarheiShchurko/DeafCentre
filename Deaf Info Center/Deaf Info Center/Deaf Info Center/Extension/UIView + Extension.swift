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
}
