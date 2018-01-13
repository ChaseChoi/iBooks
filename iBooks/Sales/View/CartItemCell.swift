//
//  CartItemCell.swift
//  iBooks
//
//  Created by Chase Choi on 13/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation
import UIKit


class CartItemCell: UITableViewCell {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    var downloadTask: URLSessionDownloadTask?
   
    var bookItem: Book? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        // set default cover image
        bookCover.image = UIImage(named: "coverPlaceholder")
        if let url = bookItem?.imageURL {
            downloadTask = bookCover.loadImage(url: url)
        }
        bookTitleLabel.text = bookItem?.title
        authorsLabel.text = bookItem?.authors
        publisherLabel.text = bookItem?.publisher
    }
}
