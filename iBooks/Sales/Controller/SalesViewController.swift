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
        
        // test db
        let dbPath = prepareDatabaseFile()
        let database: SQLiteDatabase
        
        do {
            database = try SQLiteDatabase.open(path: dbPath)
            print("Successfully open database!")
        } catch {
            print("Unable to open database!")
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.saleBookScannerView.rawValue {
            let controller = segue.destination as! ScanViewController
            controller.delegate = self
        }
    }
    
    // ref: https://stackoverflow.com/questions/44376599/sqlite-database-file-managing-in-swift-3-and-ios-copy-from-local-and-or-bundle
    func prepareDatabaseFile() -> String {
        let fileManager = FileManager.default
        let fileName = "iBooks"
        let baseURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = baseURL.appendingPathComponent(fileName).appendingPathExtension("sqlite")

        return documentURL.path
    }
}

extension SalesViewController: ScanViewControllerDelegate {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
        
    }
}
