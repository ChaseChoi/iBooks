//
//  LoginViewController.swift
//  iBooks
//
//  Created by Chase Choi on 07/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userInput: InputTextField!
    @IBOutlet weak var passwordInput: InputTextField!
    @IBOutlet weak var confirmButton: UIButton! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddTargetIsNotEmptyTextFields()
        userInput.becomeFirstResponder()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.adminLogin.rawValue {
            print("Gotcha")
        }
    }
    @IBAction func confirm() {
        
    }
    func setUpAddTargetIsNotEmptyTextFields() {
        confirmButton.isEnabled = false
        
        userInput.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        passwordInput.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        
    }
    
    @objc func textFieldsIsNotEmpty(sender: InputTextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        
        guard
            let username = userInput.text, !username.isEmpty,
            let password = passwordInput.text, !password.isEmpty else {
                confirmButton.isEnabled = false
                return
        }
        confirmButton.isEnabled = true
    }

    
}

extension LoginViewController: UITextFieldDelegate {
    // hide keyboard automatically when touching outside
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
