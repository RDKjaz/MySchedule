//
//  ScheduleColorTableViewCell.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 04.08.2022.
//

import UIKit

class ScheduleColorTableViewCell: UITableViewCell {
    
    private let backgroundViewCell: UIView = {
        let backgroundViewCell = UIView()
        backgroundViewCell.backgroundColor = .white
        backgroundViewCell.layer.cornerRadius = 10
        backgroundViewCell.translatesAutoresizingMaskIntoConstraints = false
        return backgroundViewCell
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func cellConfigure(indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.8666666667, green: 0.231372549, blue: 0.1960784314, alpha: 1)
        case [1,0]:
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.168627451, green: 0.7764705882, blue: 0.1529411765, alpha: 1)
        case [2,0]:
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.3294117647, blue: 0.7960784314, alpha: 1)
        default:
            break
        }
    }
    
    func setConstraints() {
         
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
    }
}
