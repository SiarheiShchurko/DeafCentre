//
//  HistoryCallsVc.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 29.11.22.
//

import UIKit
final class HistoryCallsVc: UIViewController {
    // MARK: Constants
    // Model
    private let historyCallsVm: HistoryCallsVm = HistoryCallsVm()
    // Percent height disp which taken header view
       private let percentHeightTaken = 0.38
    // MARK: Labels
    private let historyCallsLabel = UniversalLabel(titleText: KeysForView.historyCalls, color: .white, labelFont: .jostMedium26() ?? UIFont())
    // MARK: Buttons
    let backButtonItem: UIButton = {
        let button = BackButtonItem()
        button.addTarget(self, action: #selector(backToHomeScreen), for: .touchUpInside)
        return button
    }()
    // MARK: Views
    // Header view
    let headerView = HeaderView()
    // Table View
    private let userCallsTableView =  UITableView(frame: .zero, style: .plain)
    // MARK: System methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        constraints()
        setSuperView()
        setTableView()
    }
}

// MARK: Custom funcs
private extension HistoryCallsVc {
    // Set superView
    func setSuperView() {
        self.view.backgroundColor = .white
    }
    // Add views
    func addView() {
        view.addSubview(headerView)
        view.addSubview(userCallsTableView)
        headerView.addSubview(backButtonItem)
        headerView.addSubview(historyCallsLabel)
    }
    // Set table view
    private func setTableView() {
        userCallsTableView.translatesAutoresizingMaskIntoConstraints = false
        userCallsTableView.delegate = self
        userCallsTableView.dataSource = self
        userCallsTableView.rowHeight = LayoutConstants.inset80
        userCallsTableView.backgroundColor = .white
        userCallsTableView.layer.cornerRadius = LayoutConstants.inset20
        userCallsTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        userCallsTableView.register(HistoryTViewCell.self, forCellReuseIdentifier: HistoryTViewCell.reusedId)
    }
}
// MARK: Actions
private extension HistoryCallsVc {
    @objc func backToHomeScreen() {
        if let homeScreenVc = self.navigationController?.viewControllers.filter { $0 is HomeScreenVc }.first {
            navigationController?.popToViewController(homeScreenVc, animated: true)
        }
    }
}
// MARK: Constraints
private extension HistoryCallsVc {
    func constraints() {
        NSLayoutConstraint.activate([
            // Header view
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -LayoutConstants.inset10),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LayoutConstants.inset10),
            headerView.heightAnchor.constraint(equalToConstant: LayoutConstants.displayHeight * percentHeightTaken),
            // Back button item
            backButtonItem.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.inset24),
            backButtonItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset16),
            backButtonItem.widthAnchor.constraint(equalToConstant: LayoutConstants.width25),
            backButtonItem.heightAnchor.constraint(equalToConstant: LayoutConstants.height13),
            // History calls label
            historyCallsLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            historyCallsLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.height30),
            historyCallsLabel.topAnchor.constraint(equalTo: backButtonItem.bottomAnchor, constant: LayoutConstants.inset10),
            // Table view
            userCallsTableView.topAnchor.constraint(equalTo: historyCallsLabel.bottomAnchor, constant: LayoutConstants.inset16),
            userCallsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.inset16),
            userCallsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.inset16),
            userCallsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}
// MARK: Delegate and DataSource for table view
extension HistoryCallsVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyCallsVm.callsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HistoryTViewCell.self)", for: indexPath) as? HistoryTViewCell
        cell?.setCell(model: historyCallsVm.callsArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


