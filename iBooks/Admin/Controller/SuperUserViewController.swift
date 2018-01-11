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
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
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
            controller.delegate = self
        }
    }
    
    @IBAction func logout() {
        dismiss(animated: true, completion: nil)
    }
}

// do not wait json
// ref: https://stackoverflow.com/questions/42804320/how-to-wait-for-the-urlsession-to-finish-before-returning-the-result-from-a-func

extension SuperUserViewController: ScanViewControllerDelegate {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
         
        APIDataSource.loadJSON(isbn: isbn) { (result: Book?, status: Bool) in
            self.bookItem = result
            
            DispatchQueue.main.async {
                controller.dismiss(animated: true, completion: nil)
                if status == true {
                    // display the detail info of the book
                    self.performSegue(withIdentifier: Segue.addBookView.rawValue, sender: nil)
                } else {
                    // alert when the book is nil
                    let alert = UIAlertController(title: "网络错误", message: "请重新扫描书本条形码", preferredStyle: .alert)
                    let action = UIAlertAction(title: "好", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension SuperUserViewController: AddBooksViewControllerDelegate {
    func addBooksViewController(_ controller: AddBooksViewController, finishAdding bookItem: Book) {
        dismiss(animated: true, completion: nil)
        print("superUser get the isbn")
        print(bookItem.isbn)
    }
}
