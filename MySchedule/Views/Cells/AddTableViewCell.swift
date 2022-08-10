//
//  OptionsSchduleTableViewCell.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 03.08.2022.
//

import UIKit

class AddTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "backgroundColorAddTableViewCell")
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "labelColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let isImportantSwitch: UISwitch = {
        let isImportantSwitch = UISwitch()
        isImportantSwitch.isHidden = true
        isImportantSwitch.onTintColor = #colorLiteral(red: 0.3036392629, green: 0.3276386261, blue: 0.794909656, alpha: 1)
        isImportantSwitch.isOn = true
        isImportantSwitch.translatesAutoresizingMaskIntoConstraints = false
        return isImportantSwitch
    }()
    
    weak var isImportantSwitchDelegate: IsImportantSwitchProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setConstraints()
        
        isImportantSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        isImportantSwitchDelegate?.isImportantSwitchProtocol(value: paramTarget.isOn)
    }
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath: IndexPath, hexColor: String) {
        
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = (indexPath.section == 2 ? color : UIColor(named: "backgroundColorAddTableViewCell"))
        
        isImportantSwitch.isHidden = indexPath == [3,0] ? false : true
        isImportantSwitch.onTintColor = color
    }
    
    func cellTasksConfigure(nameArray: [[String]], indexPath: IndexPath) {
        
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
    }
    
    func cellContactsConfigure(nameArray: [String], indexPath: IndexPath, image: UIImage?) {
        
        nameCellLabel.text = nameArray[indexPath.section]
        if image == nil {
            indexPath.section == 2 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
        } else {
            indexPath.section == 2 ? backgroundViewCell.image = image : nil
            backgroundViewCell.contentMode = .scaleAspectFill
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
        
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
        ])
        
        self.contentView.addSubview(isImportantSwitch)
        NSLayoutConstraint.activate([
            isImportantSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            isImportantSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -15),
        ])
    }
}
