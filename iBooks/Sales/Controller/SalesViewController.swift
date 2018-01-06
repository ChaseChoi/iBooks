//
//  SalesViewController.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit

class SalesViewController: UIViewController {
    
    var bookList: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.salesScanner.rawValue {
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
        
        APIDataSource.loadJSON(isbn: isbn)
        // add books to data source
        
        dismiss(animated: true, completion: nil)
    }
}
