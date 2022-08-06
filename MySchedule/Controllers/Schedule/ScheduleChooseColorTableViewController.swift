//
//  ScheduleColorViewController.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 04.08.2022.
//

import UIKit

class ScheduleChooseColorTableViewController: UITableViewController {
    
    private let idScheduleChooseColorCell = "idScheduleChooseColorCell"
    private let idScheduleChooseColorHeader = "idScheduleChooseColorHeader"
    
    private let headerNameArray = ["RED", "GREEN", "BLUE"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose Color"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ScheduleColorTableViewCell.self, forCellReuseIdentifier: idScheduleChooseColorCell)
        tableView.register(HeaderAddTableViewCell.self, forHeaderFooterViewReuseIdentifier: idScheduleChooseColorHeader)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idScheduleChooseColorCell, for: indexPath) as! ScheduleColorTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idScheduleChooseColorHeader) as! HeaderAddTableViewCell
        header.headerConfigure(headerNameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: setColor(color: "DD3B32")
        case 1: setColor(color: "2BC627")
        case 2: setColor(color: "4D54CB")
        default: setColor(color: "FFFFFF")
        }
    }
    
    private func setColor(color: String) {
        let addScheduleViewController = navigationController?.viewControllers[1] as? AddScheduleTableViewController
        addScheduleViewController?.hexColorCell = color
        addScheduleViewController?.tableView.reloadRows(at: [[2,0], [3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
}

