//
//  ContactsViewController.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 20.05.2022.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let searchController = UISearchController()
    private let refreshControl = UIRefreshControl()

    private let idContactCell = "idContactCell"
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private var filteredContactsArray: Results<ContactModel>!
    
    private var isSearchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    
    private var isFiltered: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Contacts"
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactCell)
        
        loadContacts()
        
        setConstraints()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc private func addButtonTapped() {
        
        let vc = AddContactTableViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func editContact(contact: ContactModel) {
        
        let vc = AddContactTableViewController()
        vc.contactModel = contact
        vc.cellNameArray = [contact.name, contact.phone, ""]
        vc.isEditModel =  true
        vc.imageIsChanged = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func loadContacts() {
        
        contactsArray = localRealm.objects(ContactModel.self)
        tableView.reloadData()
    }
}
    
// MARK: UITableViewDelegate, UITableViewDataSource

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltered ? filteredContactsArray.count : contactsArray.count)
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactCell, for: indexPath) as! ContactsTableViewCell
        cell.configure(model: (isFiltered ? filteredContactsArray[indexPath.row] : contactsArray[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = contactsArray[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactsArray[indexPath.row]
        editContact(contact: contact)
    }
}

extension ContactsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredContactsArray = contactsArray.filter("name CONTAINS[cd] %@", searchText)
        tableView.reloadData()
    }
}

// MARK: SetConstraints

extension ContactsViewController {
    
    private func setConstraints() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}

