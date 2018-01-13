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
    static let cartListItem = "cartListItem"
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

        if segue.identifier == Segue.signUpView.rawValue {
            let controller = segue.destination as! SignUpViewController
            controller.delegate = self
        }
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
    
    // animate cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1. set up the initial state of the cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        // 2. use UIView animation method to change init into final state
        UIView.animate(withDuration: 0.5){
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
}

extension UsersListViewController: SignUpViewControllerDelegate {
    
    func signUpViewController(_ controller: SignUpViewController, didFinishSigningUp user: User) {
        
        
        let nextRowIndex = dataSource.getNumOfUsers()
        
        // update data source
        let flag = dataSource.add(user: user)
        if flag == true {
            // update table view
            let indexPath = IndexPath(row: nextRowIndex, section: 0)
            let indexPaths = [indexPath]
            tableView.insertRows(at: indexPaths, with: .automatic)
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "ID重复", message: "请修改并重新输入ID", preferredStyle: .alert)
            let action = UIAlertAction(title: "好", style: .default){
                empty in controller.idTextfield.text = ""
                controller.idTextfield.becomeFirstResponder()
                controller.signUpButton.isEnabled = false
            }
            alert.addAction(action)
            controller.present(alert, animated: true, completion: nil)
        }
        
    }
    

    
}
