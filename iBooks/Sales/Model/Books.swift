//
//  Books.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import Foundation

// get the json data
struct Book: Decodable {
    var isbn: String?
    var imageURL: String?
    var title: String?
    var author: String?
    var price: Double?
    var publisher: String?
    var number: Int?
}

extension Book {
    init(dict: [String:AnyObject], isbn: String) {
        publisher = dict["publisher"] as? String
        if let volumeInfo = dict["volumeInfo"] as? [AnyObject] {
            for data in volumeInfo {
                title = data["title"] as? String
                author = data["authors"] as? String
            }
        }
        if let imageLinks = dict["imageLinks"] as? [AnyObject] {
            for data in imageLinks {
                imageURL = data["thumbnail"] as? String
            }
        }
        price = 0
        number = 0
        self.isbn = isbn
    }
}
