//
//  TasksOptionTableViewController.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 04.08.2022.
//

import UIKit

class AddTaskTableViewController: UITableViewController {
    
    private let idAddTaskCell = "idAddTaskCell"
    private let idAddTaskHeader = "idAddTaskHeader"
    
    private let headerNameArray = [NSLocalizedString("INFORMATION", comment: "")]
    private let cellNameArray = [[NSLocalizedString("Date", comment: ""), NSLocalizedString("Task number", comment: ""), NSLocalizedString("Description", comment: "")]]
        
    private var taskModel = TaskModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Add task", comment: "")

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: idAddTaskCell)
        tableView.register(HeaderAddTableViewCell.self, forHeaderFooterViewReuseIdentifier: idAddTaskHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        
        if taskModel.date == nil || taskModel.number == "Unknown" || taskModel.desc == "Unknown" {
            alertOk(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Date, number and description are required", comment: ""))
        } else {
            RealmManager.shared.saveTaskModel(model: taskModel)
            taskModel = TaskModel()
            alertOk(title: NSLocalizedString("Succes saved", comment: ""), message: nil)
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddTaskCell, for: indexPath) as! AddTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idAddTaskHeader) as! HeaderAddTableViewCell
        header.headerConfigure(headerNameArray: headerNameArray, section: section)
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
                self.taskModel.date = date
            }
        case [0,1]:
            alertCellName(label: cell.nameCellLabel, name: NSLocalizedString("Task number", comment: ""), placeholder: NSLocalizedString("Enter task number", comment: "")) { text in
                self.taskModel.number = text
            }
        case [0,2]:
            alertCellName(label: cell.nameCellLabel, name: NSLocalizedString("Description", comment: ""), placeholder: NSLocalizedString("Enter description", comment: "")) { text in
                self.taskModel.desc = text
            }
        default:
            break
        }
    }
}
