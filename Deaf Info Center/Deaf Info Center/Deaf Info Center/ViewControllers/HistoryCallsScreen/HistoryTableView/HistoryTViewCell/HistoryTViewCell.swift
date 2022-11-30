//
//  HistoryTViewCell.swift
//  Deaf Info Center
//
//  Created by Alinser Shchurko on 29.11.22.
//

import UIKit
final class HistoryTViewCell: UITableViewCell {
    // MARK: Cell init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: HistoryTViewCell.reusedId)
        addSubview(self.avatar)
        addSubview(self.nameOperator)
        addSubview(self.date)
        addSubview(self.duration)
        constraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let dateFormatter = DateFormatter()
    static let reusedId = "HistoryTViewCell"
    let avatar: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: LayoutConstants.width44, height: LayoutConstants.height44)
        imageView.layer.cornerRadius = imageView.frame.size.width / LayoutConstants.inset2
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    let nameOperator = UniversalLabel(titleText: "", color: .black, labelFont: .jostRegular17() ?? UIFont())

    let date: UILabel = {
        let label = UniversalLabel(titleText: "", color: .gray33, labelFont: .jostLight13() ?? UIFont())
        return label
    }()
    let time: UILabel = {
        let label = UniversalLabel(titleText: "", color: .gray33, labelFont: .jostLight13() ?? UIFont())
        return label
    }()
    let duration: UILabel = {
        let label = UniversalLabel(titleText: "", color: .gray33, labelFont: .jostLight13() ?? UIFont())
        label.textAlignment = .right
        return label
    }()
    
}
// MARK: Custom funcs
extension HistoryTViewCell {
    // Set cell
    func setCell(model: UserCallsStored) {
        avatar.image = model.avatar
        nameOperator.text = model.operatorName
        // Date formatter
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        date.text = dateFormatter.string(from: model.date)
        // Duration dialogs
        let minutes = model.duration / 60
        let seconds = model.duration % 60
        duration.text = "\(minutes) min \(seconds) sec"
    }
}
// MARK: Constraints
extension HistoryTViewCell {
    private func constraints() {
        NSLayoutConstraint.activate([
            // Avatar
            avatar.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.inset16),
            avatar.widthAnchor.constraint(equalToConstant: LayoutConstants.width44),
            avatar.heightAnchor.constraint(equalToConstant: LayoutConstants.height44),
            // Operator name
            nameOperator.topAnchor.constraint(equalTo: topAnchor, constant:  LayoutConstants.inset16),
            nameOperator.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: LayoutConstants.inset4),
            nameOperator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.inset4),
            // Date
            date.topAnchor.constraint(equalTo: nameOperator.bottomAnchor, constant: LayoutConstants.inset1),
            date.leadingAnchor.constraint(equalTo: nameOperator.leadingAnchor),
            date.widthAnchor.constraint(equalToConstant: LayoutConstants.width117),
            // Duration label
            duration.centerYAnchor.constraint(equalTo: date.centerYAnchor),
            duration.trailingAnchor.constraint(equalTo: nameOperator.trailingAnchor),
            duration.widthAnchor.constraint(equalToConstant: LayoutConstants.width87)
        ])
    }
}
