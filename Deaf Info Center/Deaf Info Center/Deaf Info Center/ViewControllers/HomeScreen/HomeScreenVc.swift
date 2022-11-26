//
//  HomeScreen.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 26.11.22.
//

import UIKit

final class HomeScreenVc: UIViewController {
    // MARK: Constants
    private let homeModel = HomeScreenVm()
    
    // MARK: Views
    private let headerView = HeaderView()
    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: KeysForImage.appLogoButton) ?? UIImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    // MARK: Labels
    // Time label
    private lazy var timeLabel: UILabel = {
        let label = SecondaryLabel(titleText: "", color: .white, labelFont: .jostRegular50() ?? UIFont())
        label.textAlignment = .center
        return label
    }()
    // Date label
    private lazy var dateLabel: UILabel = {
        let label = SecondaryLabel(titleText: "", color: .white, labelFont: .jostRegular14() ?? UIFont())
        label.textAlignment = .center
        return label
    }()
    // MARK: Buttons
    private let menuButton = OneImageButton(image: UIImage(named: KeysForImage.verticalEllipsFigma) ?? UIImage())
    private let videoCallButton = OneImageButton(image: UIImage(named: KeysForImage.videoCallIFigma) ?? UIImage())
    private let historyCallsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Istoria apelurilor", for: .normal)
        button.setTitleColor(.purpoureLight, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = UIFont.jostRegular17()
        button.setImage(UIImage(named: KeysForImage.historyCallsFigma)?.withTintColor(UIColor.purpoureLight, renderingMode: .alwaysOriginal), for: .normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: LayoutConstants.inset1, left: 0, bottom: 50, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 1, right: 10)
        
        
        return button
    }()
    // MARK: System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setSuperView()
        addView()
        constraints()
        homeModel.dateDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeModel.loadDate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        homeModel.timer?.invalidate()
    }
}
// MARK: Custom funcs
private extension HomeScreenVc {
    // Super view set
    func setSuperView() {
        view.backgroundColor = .backgroundWhiteColor
    }
    // Add view on superview
    func addView() {
        view.addSubview(headerView)
        headerView.addSubview(menuButton)
        headerView.addSubview(logoImage)
        headerView.addSubview(timeLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(videoCallButton)
        view.addSubview(historyCallsButton)
    }
}
// MARK: Constraints
private extension HomeScreenVc {
    func constraints() {
        NSLayoutConstraint.activate([
            // Header view
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.inset100),
            // Menu button
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.inset24),
            menuButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -LayoutConstants.inset26),
            menuButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height22),
            menuButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width22),
            // Logo image
            logoImage.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: LayoutConstants.inset40),
            logoImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: LayoutConstants.inset66),
            logoImage.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -LayoutConstants.inset66),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
            // Time label
            timeLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: LayoutConstants.inset36),
            timeLabel.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.width143),
            timeLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height72),
            // Date label
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.width87),
            dateLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height20),
            // Video call button
            videoCallButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            videoCallButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -LayoutConstants.inset16),
            videoCallButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width90),
            videoCallButton.heightAnchor.constraint(equalToConstant: LayoutConstants.height90),
            // History calls button
            historyCallsButton.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            historyCallsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: LayoutConstants.inset21),
            historyCallsButton.widthAnchor.constraint(equalToConstant: LayoutConstants.width117),
            historyCallsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}
// Extension for delegate date and time to self VC
extension HomeScreenVc: GiveAwayDateProtocol {
    func giveAwayTime(time: String) {
        DispatchQueue.main.async {
            self.timeLabel.text = time
        }
    }
    func giveAwayDate(date: String) {
        DispatchQueue.main.async {
            self.dateLabel.text = date
        }
    }
}
