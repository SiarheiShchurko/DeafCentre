//
//  BasicButtonWithImage.swift
//  DeafInfoCenter
//
//  Created by Alinser Shchurko on 17.11.22.
//

import Foundation
import UIKit

final class BasicImageButton: UIButton {
    var image: UIImage
    init(image: UIImage) {
        self.image = image
        super.init(frame: .zero)
        setButton(image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension BasicImageButton {
    private func setButton(image: UIImage) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(image, for: .normal)
        self.contentMode = .scaleAspectFit
    }
}
