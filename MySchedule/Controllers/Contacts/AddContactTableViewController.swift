//
//  AddContactTableViewController.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 05.08.2022.
//

import UIKit

class AddContactTableViewController: UITableViewController {
    
    private let idAddContactCell = "idAddContactCell"
    private let idAddContactHeader = "idAddContactHeader "
    
    private let headerNameArray = [NSLocalizedString("NAME", comment: ""), NSLocalizedString("PHONE", comment: ""), NSLocalizedString("CHOOSE IMAGE", comment: "")]
    var cellNameArray = [NSLocalizedString("Name", comment: ""), NSLocalizedString("Phone", comment: ""), ""]
    
    var imageIsChanged = false
    var isEditModel = false
    var dataImage: Data?
    var contactModel = ContactModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Add contact", comment: "")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: idAddContactCell)
        tableView.register(HeaderAddTableViewCell.self, forHeaderFooterViewReuseIdentifier: idAddContactHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        print(contactModel)
    }
    
    @objc private func saveButtonTapped() {
        
        if cellNameArray[0] == NSLocalizedString("Name", comment: "") || cellNameArray[1] == NSLocalizedString("Phone", comment: "") {
            alertOk(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Name and phone are required", comment: ""))
        } else if isEditModel == false {
            setImageModel()
            setModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            cellNameArray = [NSLocalizedString("Name", comment: ""), NSLocalizedString("Phone", comment: ""), ""]
            alertOk(title: NSLocalizedString("Succes saved", comment: ""), message: nil)
            tableView.reloadData()
        } else {
            setImageModel()
            
            RealmManager.shared.upadateContactModel(model: contactModel, nameArray: cellNameArray, imageData: dataImage)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setModel() {
        contactModel.name = cellNameArray[0]
        contactModel.phone = cellNameArray[1]
        contactModel.avatar = dataImage
    }
    
    private func setImageModel() {
        
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [2,0]) as! AddTableViewCell
            
            let image = cell.backgroundViewCell.image
            if image != UIImage(systemName: "person.fill.badge.plus") {
                guard let imageData = image?.pngData() else { return }
                dataImage = imageData
                cell.backgroundViewCell.contentMode = .scaleAspectFit
            }
            imageIsChanged = false
        } else {
            dataImage = nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddContactCell, for: indexPath) as! AddTableViewCell
        
        if isEditModel == false {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactModel.avatar, let image = UIImage(data: data) {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: image)
        } else {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 2 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idAddContactHeader) as! HeaderAddTableViewCell
        header.headerConfigure(headerNameArray: headerNameArray,  section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        let cell = tableView.cellForRow(at: indexPath) as! AddTableViewCell
        
        switch indexPath.section {
        case 0:
            alertCellName(label: cell.nameCellLabel, name: NSLocalizedString("Contact name", comment: ""), placeholder: NSLocalizedString("Enter contact name", comment: "")) { text in
                self.cellNameArray[0] = text
            }
        case 1:
            alertCellName(label: cell.nameCellLabel, name: NSLocalizedString("Phone", comment: ""), placeholder: NSLocalizedString("Enter phone", comment: "")) { text in
                self.cellNameArray[1] = text
            }
        case 2:
            alertPhotoCamera { [self] source in
                chooseImagePicker(source: source)
            }
        default:
            break
        }
    }
}

extension AddContactTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell = tableView.cellForRow(at: [2,0]) as! AddTableViewCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}

