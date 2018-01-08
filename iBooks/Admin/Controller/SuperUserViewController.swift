//
//  SuperUserViewController.swift
//  iBooks
//
//  Created by Chase Choi on 08/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit

class SuperUserViewController: UIViewController {
    var bookItem: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.addBookScannerView.rawValue {
            let controller = segue.destination as! ScanViewController
            controller.delegate = self
        } else if segue.identifier == Segue.addBookView.rawValue {
            
            let navigation = segue.destination as! UINavigationController
            let controller = navigation.topViewController as! AddBooksViewController
            controller.bookItem = bookItem
        }
    }
}

extension SuperUserViewController: ScanViewControllerDelegate {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
        print("Superuser got isbn: \(isbn)")
        APIDataSource.loadJSON(isbn: isbn) { (result: Book?) in
            self.bookItem = result
        }
        dismiss(animated: true, completion: nil)
        if bookItem != nil {
            performSegue(withIdentifier: Segue.addBookView.rawValue, sender: nil)
        }
        // TODO - warning when book is nil
        print("Book is nil!")
    }
}
