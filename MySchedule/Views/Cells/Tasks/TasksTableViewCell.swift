//
//  TasksTableViewCell.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 03.08.2022.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    let number = UILabel(text: "Task number")
    let desc = UILabel(text: "Description")
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate: TapReadyTaskButtonProtocol?
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    @objc func readyButtonTapped() {
        guard let index = index else { return }
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
    func configure(model: TaskModel) {
        
        number.text = model.number
        desc.text = model.desc
        
        model.isReady == true
            ? readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
            : readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
    }
    
    func setConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [number, desc], axis: .vertical, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
        ])
        
        self.contentView.addSubview(readyButton)
        NSLayoutConstraint.activate([
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
