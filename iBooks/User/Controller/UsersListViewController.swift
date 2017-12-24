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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.addUser.rawValue {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddUserViewController
            controller.delegate = self
        }
    }
    
    @IBAction func unwindAddUserCancel(with segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
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

extension UsersListViewController: AddUserViewControllerDelegate {
    func addUserViewController(_ controller: AddUserViewController, didFinishAdding item: User) {
        
    }
}
