//
//  UsersListViewController.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit

struct TableViewReuseIdentifier {
    static let userListCell = "userThumbnail"
}

class UsersListViewController: UIViewController {
    
    let dataSource = UserDataSource()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //avoid the last cell from cutting off
        let tabBarHeight = CGFloat(49)
        edgesForExtendedLayout = UIRectEdge.all
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarHeight, right: 0.0)
        
        dataSource.fetch()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == Segue.addUser.rawValue {
//            let navigationController = segue.destination as! UINavigationController
//            let controller = navigationController.topViewController as! AddUserViewController
//            controller.delegate = self
//        }
        if segue.identifier == Segue.signUpUser.rawValue {
            let navgatinController = segue.destination as! UINavigationController
            let controller = navgatinController.topViewController as! SignUpViewController
            controller.delegate = self
        }
    }
    
    @IBAction func unwindAddUserCancel(with segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindSignUpCancel(with segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumOfUsers()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewReuseIdentifier.userListCell, for: indexPath) as! UserCell
        cell.userItem = dataSource.getUser(at: indexPath)
        return cell
        
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // update data source
        dataSource.deleteUser(at: indexPath)
        
        //update table view
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    // change the title of delete confirmation button
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}

extension UsersListViewController: SignUpViewControllerDelegate {
    
    func signUpViewController(_ controller: SignUpViewController, didFinishSigningUp user: User) {
        let nextRowIndex = dataSource.getNumOfUsers()
        
        // update data source
        dataSource.add(user: user)
        
        // update table view
        let indexPath = IndexPath(row: nextRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }
    

    
}
extension UsersListViewController: AddUserViewControllerDelegate {
    func addUserViewController(_ controller: AddUserViewController, didFinishAdding item: User) {
        let nextRowIndex = dataSource.getNumOfUsers()

        // update data source
        dataSource.add(user: item)

        // update table view
        let indexPath = IndexPath(row: nextRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }
}

