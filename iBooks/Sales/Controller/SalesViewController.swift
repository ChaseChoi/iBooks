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
        if segue.identifier == Segue.scannerView.rawValue {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ScanViewController
            controller.delegate = self
        }
    }
    @IBAction func unwindScanCancel(with segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}

extension SalesViewController: ScanViewControllerDelegate {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
        print("Get ISBN: \(isbn)")
        
        APIDataSource.loadJSON(isbn: isbn) { (result: Book?) in
            self.bookItem = result
        }
        dismiss(animated: true, completion: nil)
    }
}
