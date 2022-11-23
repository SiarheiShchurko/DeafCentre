//
//  BackButtonItem.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 19.11.22.
//

import UIKit
final class BackButtonItem: UIButton {
    init() {
        super.init(frame: .zero)
        setBackButtonItem()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BackButtonItem {
    private func setBackButtonItem() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(named: KeysForImage.backBarButtonItem)?.withTintColor(.whiteWithAlpha40, renderingMode: .alwaysOriginal), for: .normal)
    }
}
