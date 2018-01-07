//
//  SignUpViewController.swift
//  iBooks
//
//  Created by Chase Choi on 07/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit
protocol SignUpViewControllerDelegate: class {
    func signUpViewController(_ controller: SignUpViewController, didFinishSigningUp user: User)
}

class SignUpViewController: UIViewController {
    weak var delegate: SignUpViewControllerDelegate?
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var phoneTextfield: InputTextField!
    @IBOutlet weak var userNameTextfield: InputTextField!
    @IBOutlet weak var idTextfield: InputTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAddTargetIsNotEmptyTextFields()
        idTextfield.becomeFirstResponder()
        
    }
    
    @IBAction func confirm() {
        let name = userNameTextfield.text!
        let id = idTextfield.text!
        let phone = phoneTextfield.text!
        let user = User(uid: id, name: name, phone: phone)
        delegate?.signUpViewController(self, didFinishSigningUp: user)
    }
    
    // prevent all the textfields from being empty
    func setUpAddTargetIsNotEmptyTextFields() {
        signUpButton.isEnabled = false
        
        idTextfield.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        phoneTextfield.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        userNameTextfield.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: InputTextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let id = idTextfield.text, !id.isEmpty,
            let phone = phoneTextfield.text, !phone.isEmpty,
            let name = userNameTextfield.text, !name.isEmpty else {
                signUpButton.isEnabled = false
                return
        }
        signUpButton.isEnabled = true
    }

}

extension SignUpViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // user return key to switch between text fields
    /* ref: https://stackoverflow.com/questions/31766896/switching-between-text-fields-on-pressing-return-key-in-swift/31766986 */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? InputTextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
}
