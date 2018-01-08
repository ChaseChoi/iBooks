//
//  AddBooksViewController.swift
//  iBooks
//
//  Created by Chase Choi on 07/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit
import Dispatch

class AddBooksViewController: UITableViewController {
    var bookItem: Book?
    var downloadTask: URLSessionDownloadTask?
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI() {
        coverImageView.image = UIImage(named: "coverPlaceholder")
        if let url = bookItem?.imageURL {
            downloadTask = coverImageView.loadImage(url: url)
        }
        if let title = bookItem?.title {
            titleLabel.text! = title
        }
        if let isbn = bookItem?.isbn {
            isbnLabel.text! = isbn
        }
        if let author = bookItem?.authors {
            authorLabel.text! = author
        }
        if let publisher = bookItem?.publisher {
            publisherLabel.text! = publisher
        }
    }
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func done() {
        let hudView = HUDView.hud(inView: navigationController!.view, animated: true)
        hudView.text = "完成"
        // delay to finish the hud
        let delayInSeconds = 0.6
        afterDelay(delayInSeconds) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
