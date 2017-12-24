//
//  UserCell.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var vipLabel: UILabel!
    
    var userItem: User? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        phoneLabel.text = userItem?.phone
        idLabel.text = userItem?.uid
        nameLabel.text = userItem?.name
        amountLabel.text = userItem?.amount
        vipLabel.text = userItem?.vip
    }
}
