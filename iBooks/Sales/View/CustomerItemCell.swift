//
//  CustomerItemCell.swift
//  iBooks
//
//  Created by Chase Choi on 14/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation
import UIKit

class CustomerItemCell: UITableViewCell {
    var user: User? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    
    func updateUI() {
        usernameLabel.text = user?.name
        idLabel.text = user?.uid
    }
}
