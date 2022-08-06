//
//  ScheduleTableViewCell.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 02.08.2022.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    let name = UILabel(text: "Task")
    let place = UILabel(text: "Place")
    let time = UILabel(text: "Time")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func configure(model: ScheduleModel) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        name.text = model.name
        place.text = model.place
        guard let timeSchedule = model.time else { return }
        time.text = formatter.string(from: timeSchedule)
        backgroundColor = UIColor().colorFromHex(model.color)
    }
    
    func setConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [name, place], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        self.addSubview(time)
        NSLayoutConstraint.activate([
            time.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            time.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            time.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
