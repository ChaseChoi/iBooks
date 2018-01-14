//
//  PaymentViewController.swift
//  iBooks
//
//  Created by Chase Choi on 14/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit

/// display price and confirm the payment here
class PaymentViewController: UIViewController {
    var amount = 0.0
    var paymentListTableview: UITableView?
    @IBOutlet weak var finalAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalAmountLabel.text = String(format: "%.2f", amount)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showPayment.rawValue {
            let controller = segue.destination as! PaymentDetailViewController
            controller.currentAmount = amount
        }
    }
}




