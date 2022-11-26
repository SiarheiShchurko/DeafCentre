//
//  CornerAngleView.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 19.11.22.
//
import Foundation
import UIKit
final class HeaderView: UIView  {
    init() {
        super.init(frame: .zero)
        setUpHeaderView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    }


private extension HeaderView {
    private func setUpHeaderView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .purpoureLight
        self.layer.cornerRadius = LayoutConstants.inset160
        self.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
}
