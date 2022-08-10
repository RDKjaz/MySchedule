//
//  ContactsTableViewCell.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 04.08.2022.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    private let avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel = UILabel(text: "")
    
    private let phoneImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "phone.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let phoneLabel = UILabel(text: "")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func configure(model: ContactModel) {
        
        nameLabel.text = model.name
        phoneLabel.text = model.phone
        
        if let data = model.avatar, let image = UIImage(data: data) {
            avatarImage.image = image
        } else {
            avatarImage.image = UIImage(systemName: "person.fill")
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
    }
    
    func setConstraints() {
        
        self.addSubview(avatarImage)
        NSLayoutConstraint.activate([
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
        ])
        
        let topStackView = UIStackView(arrangedSubviews: [phoneImage, phoneLabel], axis: .horizontal, spacing: 10, distribution: .fillProportionally)

        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
        ])
    }
}

