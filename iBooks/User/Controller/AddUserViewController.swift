//
//  AddUserViewController.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit

protocol AddUserViewControllerDelegate: class {
    func addUserViewController(_ controller: AddUserViewController, didFinishAdding item: User)
}

class AddUserViewController: UITableViewController {
    
    weak var delegate: AddUserViewControllerDelegate?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.becomeFirstResponder()
    }
    
    @IBAction func done() {
        let name = nameTextField.text!
        let id = idTextField.text!
        let phone = phoneTextField.text!
        let user = User(uid: id, name: name, phone: phone)
        delegate?.addUserViewController(self, didFinishAdding: user)
    }
    
    func warningOfLossInput() {
        let alert = UIAlertController(title: "信息不全", message: "请输入用户名，手机等信息", preferredStyle: .alert)
        let action = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension AddUserViewController {
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
extension AddUserViewController: UITextFieldDelegate {
    // avoid id textfield from inputing nothing
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneButton.isEnabled = (newText.length > 0)
        return true
    }
}
