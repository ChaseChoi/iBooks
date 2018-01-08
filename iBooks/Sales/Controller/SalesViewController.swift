//
//  SalesViewController.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit

class SalesViewController: UIViewController {
    
    var bookItem: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.saleBookScannerView.rawValue {
            let controller = segue.destination as! ScanViewController
            controller.delegate = self
        }
    }
}

extension SalesViewController: ScanViewControllerDelegate {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
        print("Sales got ISBN: \(isbn)")
        
        APIDataSource.loadJSON(isbn: isbn) { (result: Book?) in
            self.bookItem = result
        }
        dismiss(animated: true, completion: nil)
    }
}
