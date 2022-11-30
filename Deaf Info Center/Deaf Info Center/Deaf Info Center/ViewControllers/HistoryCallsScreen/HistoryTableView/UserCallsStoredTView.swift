//
//  TableView.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 29.11.22.
//

//import UIKit
//final class UserCallsStoredTableView: UITableView {
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: .plain)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.delegate = self
//        self.dataSource = self
//        self.rowHeight = LayoutConstants.inset80
//        self.backgroundColor = .white
//        self.layer.cornerRadius = 20
//        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        userCallsTableView.register(HistoryTViewCell.self, forCellReuseIdentifier: HistoryTViewCell.reusedId)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//  //  private var array: [UserCallsStored] = []
//    private var historyCallsVm = HistoryCallsVm()
//}
//
//extension UserCallsStoredTableView: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return historyCallsVm.callsArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//        let cell = tableView.dequeueReusableCell(withIdentifier: "\(HistoryTViewCell.self)", for: indexPath) as? HistoryTViewCell
//        cell?.setCell(model: historyCallsVm.callsArray.count[indexPath.row])
//        return cell ?? UITableViewCell()
//    }
//}
//
//extension UserCallsStoredTableView: UserCallsTViewDelegateProtocol {
//    func delegateArrayCalls(callsArray: [UserCallsStored]) {
//     array = callsArray
//    }
//}
