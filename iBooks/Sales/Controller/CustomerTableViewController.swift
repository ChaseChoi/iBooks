//
//  CustomerTableViewController.swift
//  iBooks
//
//  Created by Chase Choi on 14/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit
protocol CustomerListViewControllerDelegate: class {
    func customerListViewControllerDelegate(_ controller: CustomerTableViewController, finishSelecting user: User)
}


class CustomerTableViewController: UITableViewController {
    var userList = [User]()
    weak var delegate: CustomerListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! userList = AppDatabase.getAllUsers()!
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewReuseIdentifier.customerCell, for: indexPath) as! CustomerItemCell
        cell.user = userList[indexPath.row]
        cell.accessoryType = .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.customerListViewControllerDelegate(self, finishSelecting: userList[indexPath.row])
    }
    
}
