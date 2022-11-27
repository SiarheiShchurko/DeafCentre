//
//  CallScreenVc.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 27.11.22.
//

import UIKit
final class CallScreenVc: UIViewController {
    // MARK: Labels
    private let lookFreeOperatorLabel: UILabel = {
        let label = UniversalLabel(titleText: KeysForView.lookFreeOperator, color: .white, labelFont: .jostRegular18() ?? UIFont())
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    // MARK: Buttons
    private let loudCommunication: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: KeysForImage.micFigma) ?? UIImage(), for: .normal)
        button.contentMode = .scaleAspectFit

        return button
    }()
    private let reverseCamera: UIButton = {
       let button = OneImageButton(image: UIImage(named: KeysForImage.cameraReverseFigma) ?? UIImage())
        return button
    }()
    private let finishCall: UIButton = {
       let button = OneImageButton(image: UIImage(named: KeysForImage.finishCallFigma) ?? UIImage())
        button.addTarget(self, action: #selector(disMissScreen), for: .touchUpInside)
        return button
    }()
    // MARK: Views
    // Horizontal ellipse image
    private let ellipseImage: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: KeysForImage.horizontalEllipseFigma) ?? UIImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.loudCommunication, self.reverseCamera, self.finishCall])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        let constraintsForStackView = LayoutConstants.inset80
        stackView.spacing = LayoutConstants.inset45
        stackView.frame.size = CGSize(width: LayoutConstants.displayWidth - constraintsForStackView, height: loudCommunication.frame.height)
        return stackView
        
    }()
    // MARK: System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperView()
        addView()
        constraints()
    }
}
// MARK: Custom methods
private extension CallScreenVc {
    // Set Super view
    func setSuperView() {
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.259, green: 0.263, blue: 0.525, alpha: 1).cgColor,
          UIColor(red: 0.202, green: 0.208, blue: 0.654, alpha: 1).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 0.52, c: -0.52, d: 0, tx: 0.76, ty: 0.48))
        layer0.position = view.center
        layer0.frame = view.bounds
        view.layer.addSublayer(layer0)
    }
    // Add view func
    func addView() {
       // view.addSubview(finishCall)
        view.addSubview(lookFreeOperatorLabel)
        view.addSubview(ellipseImage)
        view.addSubview(buttonsStackView)
    }
}
// MARK: Actions
private extension CallScreenVc {
   @objc func disMissScreen() {
        self.dismiss(animated: true)
    }
}
// MARK: Constraints
private extension CallScreenVc {
    func constraints() {
        NSLayoutConstraint.activate([
            // Finding free operators
            lookFreeOperatorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutConstants.inset168),
            lookFreeOperatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset53),
            lookFreeOperatorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset53),
            lookFreeOperatorLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height60),
            // Ellipse image
            ellipseImage.topAnchor.constraint(equalTo: lookFreeOperatorLabel.bottomAnchor, constant: LayoutConstants.inset24),
            ellipseImage.widthAnchor.constraint(equalToConstant: LayoutConstants.width44),
            ellipseImage.heightAnchor.constraint(equalToConstant: LayoutConstants.height13),
            ellipseImage.centerXAnchor.constraint(equalTo: lookFreeOperatorLabel.centerXAnchor),
            // Button Stack view
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.inset66),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
