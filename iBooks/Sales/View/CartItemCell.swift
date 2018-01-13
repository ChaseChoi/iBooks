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
    @IBOutlet weak var priceLabel: UILabel!
    
    var bookItem: Book? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        if let url = bookItem?.imageURL {
            bookCover.loadImage(url: url)  
            
        } else {
            bookCover.image = UIImage(named: "coverPlaceholder")
        }
        bookTitleLabel.text = bookItem?.title
        authorsLabel.text = bookItem?.authors
        publisherLabel.text = bookItem?.publisher
        if let book = bookItem {
            priceLabel.text = String(format: "%.2f", book.price)
        }
        
    
        
        
    }
}
