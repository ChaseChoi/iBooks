//
//  UsersListViewController.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {
    let reuseIdentifier = "userThumbnail"
    let dataSource = UserDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // test
        dataSource.fetch()
        
    }

}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumOfUsers()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.userItem = dataSource.getUser(at: indexPath) 
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
