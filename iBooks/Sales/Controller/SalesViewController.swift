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
    
    var bookItem: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let book = Book(isbn: "86", imageURL: URL.init(string: "www.baidu.com"), title: "Steve", authors: "Chase", price: 100, categories: "Biography", publisher: "Crown", number: 120)
        
//        do {
//            try AppDatabase.insertBook(named: book)
//        } catch let error as DatabaseError  where error.resultCode == .SQLITE_CONSTRAINT  {
//            print("same book")
//        } catch {
//            print("Insert error!")
//        }
       
        
        if let book = try! AppDatabase.getBook(with: "86") {
            if let url = book.imageURL {
               print(url)
            }
        } else {
            print( "no such books" )
        }
   
//        if let books = try! AppDatabase.getAllBooks() {
//            for book in books {
//                print(book.isbn)
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.saleBookScannerView.rawValue {
            let controller = segue.destination as! ScanViewController
            controller.delegate = self
        }
    }
    
//    // ref: https://stackoverflow.com/questions/44376599/sqlite-database-file-managing-in-swift-3-and-ios-copy-from-local-and-or-bundle
//    func prepareDatabaseFile() -> String {
//        let fileManager = FileManager.default
//        let fileName = "iBooks"
//        let baseURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let documentURL = baseURL.appendingPathComponent(fileName).appendingPathExtension("sqlite")
//
//        return documentURL.path
//    }
}

extension SalesViewController: ScanViewControllerDelegate {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
        
    }
}
