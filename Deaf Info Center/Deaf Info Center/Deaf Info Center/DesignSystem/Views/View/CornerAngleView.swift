//
//  CornerAngleView.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 19.11.22.
//
import Foundation
import UIKit
final class OneCornerRadiusView: UIView  {
    init() {
        super.init(frame: .zero)
        setUpCornerView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    }


private extension OneCornerRadiusView {
    private func setUpCornerView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .purpoureLight
        self.layer.cornerRadius = LayoutConstants.inset160
        self.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
}
