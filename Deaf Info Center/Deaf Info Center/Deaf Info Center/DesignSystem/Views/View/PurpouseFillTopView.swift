//
//  PurpouseFillTopView.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 19.11.22.
//

import UIKit

final class PurpouseTopFillView: UIView {
    init() {
        super.init(frame: .zero)
        setUpTopFillView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PurpouseTopFillView {
    private func setUpTopFillView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .purpoureMidnight
    }
}
