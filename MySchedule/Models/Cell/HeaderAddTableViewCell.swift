//
//  OptionsScheduleTableViewHeader.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 03.08.2022.
//

import UIKit

class HeaderAddTableViewCell: UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "")
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func headerConfigure(headerNameArray: [String], section: Int) {
        headerLabel.text = headerNameArray[section]
    }
    
    func setConstraints() {
         
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}

