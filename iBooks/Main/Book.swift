//
//  Book.swift
//  iBooks
//
//  Created by Chase Choi on 06/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation
import GRDB

struct Book: Codable {
    var isbn: String
    var imageURL: URL?
    var title: String
    var authors = "未知"
    var price = 0.0
    var categories = "未知"
    var publisher = "未知"
    var number = 0
}

extension Book {

    init(data: APIData) {
        let bookItem = data.items![0]
        
        title = bookItem.getTitle()
        isbn = bookItem.getISBN_13()
        if let authors = bookItem.getAuthors() {
            self.authors = authors
        }
        if let publisher = bookItem.getPublisher() {
            self.publisher = publisher
        }
        imageURL = bookItem.getImageUrl()
        if let categories = bookItem.getCategories() {
            self.categories = categories
        }
    }
    
    /**
     - parameter number: the number of books to add/substract
     */
    mutating func changeNumberOfBooks(number: Int) {
        self.number += number
    }
    
    
    mutating func changePrice(to number: Double) {
        price = number
    }
    
    /// set number of books to 1
    mutating func setDefaultNumber() {
        number = 1
    }
}

extension Book: SQLTable {
    static var createStatement: String {
        return """
        create table if not exists \(tableName.Books.rawValue) (
            isbn TEXT PRIMARY KEY NOT NULL,
            imageURL TEXT,
            title TEXT,
            authors TEXT,
            price REAL,
            categories TEXT,
            publisher TEXT,
            number INT
        );
        """
    }

}
extension Book: RowConvertible, Persistable {
    static let databaseTableName = tableName.Books.rawValue
}
