//
//  OptionsSchdeuleViewController.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 03.08.2022.
//

import UIKit
import SwiftUI

class AddScheduleTableViewController: UITableViewController {
    
    private let idAddScheduleCell = "idAddScheduleCell"
    private let idAddScheduleHeader = "idAddScheduleHeader"
    
    private let headerNameArray = [NSLocalizedString("DATE AND TIME", comment: ""), NSLocalizedString("INFORMATION", comment: ""), NSLocalizedString("COLOR", comment: ""), NSLocalizedString("IMPORTANT", comment: ""),]
    private let cellNameArray = [[NSLocalizedString("Date", comment: ""), NSLocalizedString("Time", comment: "")], [NSLocalizedString("Name", comment: ""), NSLocalizedString("Place", comment: "")], [""], [NSLocalizedString("Important", comment: "")]]
    
    private var scheduleModel = ScheduleModel()
    
    var hexColorCell = "4D54CB"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Add schedule", comment: "")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: idAddScheduleCell)
        tableView.register(HeaderAddTableViewCell.self, forHeaderFooterViewReuseIdentifier: idAddScheduleHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        
        if scheduleModel.date == nil || scheduleModel.time == nil || scheduleModel.name == "Unknown" {
            alertOk(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Date, time and name are required", comment: ""))
        } else {
            scheduleModel.color = hexColorCell
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            //tableView.reloadRows(at: [[0,0], [0,1], [1,0], [1,1], [2,0], [3,0]], with: .none)
            alertOk(title: NSLocalizedString("Succes saved", comment: ""), message: nil)
            hexColorCell = "4D54CB"
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 2
        case 2: return 1
        case 3: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddScheduleCell, for: indexPath) as! AddTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        cell.isImportantSwitchDelegate = self
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idAddScheduleHeader) as! HeaderAddTableViewCell
        header.headerConfigure(headerNameArray: headerNameArray,  section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        let cell = tableView.cellForRow(at: indexPath) as! AddTableViewCell
        
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLabel) { date in
                self.scheduleModel.date = date
            }
        case [0,1]:
            alertTime(label: cell.nameCellLabel) { time in
                self.scheduleModel.time = time
            }
        case [1,0]:
            alertCellName(label: cell.nameCellLabel, name: NSLocalizedString("Name", comment: ""), placeholder: NSLocalizedString("Enter Name", comment: "")) { text in
                self.scheduleModel.name = text
            }
        case [1,1]:
            alertCellName(label: cell.nameCellLabel, name: NSLocalizedString("Place", comment: ""), placeholder: NSLocalizedString("Enter place", comment: "")) { text in
                self.scheduleModel.place = text
            }
        case [2,0]:
            let vc = ScheduleChooseColorTableViewController()
            //vc.modalPresentationStyle = .popover
            //present(vc, animated: true, completion: nil)
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

extension AddScheduleTableViewController: IsImportantSwitchProtocol {
    func isImportantSwitchProtocol(value: Bool) {
        scheduleModel.isImportant = value
    }
}
