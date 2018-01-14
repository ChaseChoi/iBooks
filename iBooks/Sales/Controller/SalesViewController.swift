//
//  SalesViewController.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit
import GRDB

class SalesViewController: UIViewController {
    
    @IBOutlet weak var cartListView: UITableView!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    var bookItem: Book?
    let dataSource = SalesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // dynamic height
        cartListView.estimatedRowHeight = cartListView.rowHeight
        cartListView.rowHeight = UITableViewAutomaticDimension
        confirmButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.saleBookScannerView.rawValue {
            let controller = segue.destination as! ScanViewController
            controller.delegate = self
        }
    }
    
}

extension SalesViewController: ScanViewControllerDelegate {
    /// get isbn data from ScanViewController
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
        dismiss(animated: true, completion: nil)
        if let book = self.dataSource.fetchBookFromDatabase(with: isbn) {
            let nextRowIndex = dataSource.getNumOfItems()
            
            var newBook = book
            newBook.setDefaultNumber()
            
            // update data source
            if self.dataSource.add(book: newBook) {
                // update UI
                let indexPath = IndexPath(row: nextRowIndex, section: 0)
                let indexPaths = [indexPath]
                self.cartListView.insertRows(at: indexPaths, with: .automatic)
            } else {
                self.cartListView.reloadData()
            }
            
        } else {
            let alert = UIAlertController(title: "图书数据获取失败", message: "请咨询相关工作人员!", preferredStyle: .alert)
            let action = UIAlertAction(title: "好", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension SalesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = dataSource.getNumOfItems()
        if numberOfRows == 0 {
            cartListView.isHidden = true
            confirmButton.isEnabled = false
        } else {
            cartListView.isHidden = false
            confirmButton.isEnabled = true
        }
        return numberOfRows
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewReuseIdentifier.cartListItem, for: indexPath) as! CartItemCell
        cell.bookItem = dataSource.getBookItem(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataSource.deleteBook(at: indexPath)
        
        // update UI
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}
