//
//  SuperUserViewController.swift
//  iBooks
//
//  Created by Chase Choi on 08/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit

class SuperUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.addBookScannerView.rawValue {
            let controller = segue.destination as! ScanViewController
            controller.delegate = self
        }
    }
}

extension SuperUserViewController: ScanViewControllerDelegate {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String) {
        print("Superuser got isbn: \(isbn)")
        dismiss(animated: true, completion: nil)
    }
}
