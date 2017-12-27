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

        // Do any additional setup after loading the view.
    }


}
extension AdminViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
