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
    
    var paymentListTableview: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.showPayment.rawValue {
            let controller = segue.destination as! UITableViewController
            paymentListTableview = controller.tableView
        }
    }
}




