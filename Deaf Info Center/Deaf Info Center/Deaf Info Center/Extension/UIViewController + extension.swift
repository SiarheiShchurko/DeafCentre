//
//  UIViewController + Extension.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 23.11.22.
//

import UIKit

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}
