//
//  ImageViewForAvatar.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 30.11.22.
//

import UIKit
final class ImageViewForAvatar: UIImageView {
    var avatarImage: UIImage
    init(avatarImage: UIImage) {
        self.avatarImage = avatarImage
        super.init(frame: .zero)
        setAvatarImage(avatarImage: avatarImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// Set avatar image
private extension ImageViewForAvatar {
    func setAvatarImage(avatarImage: UIImage) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = avatarImage
        self.layer.cornerRadius = self.frame.size.width / LayoutConstants.inset2
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
}
