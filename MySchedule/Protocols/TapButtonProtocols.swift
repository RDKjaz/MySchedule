//
//  TapButtonProtocol.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 03.08.2022.
//

import Foundation

protocol TapReadyTaskButtonProtocol: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}

protocol IsImportantSwitchProtocol: AnyObject {
    func isImportantSwitchProtocol(value: Bool)
}
