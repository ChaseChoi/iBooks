//
//  AdminViewController.swift
//  iBooks
//
//  Created by Chase Choi on 27/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {

    @IBOutlet weak var userInput: InputTextField!
    @IBOutlet weak var passwordInput: InputTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
extension AdminViewController: UITextFieldDelegate {
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
