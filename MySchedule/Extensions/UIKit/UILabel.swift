//
//  UILabel.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 03.08.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.textColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
