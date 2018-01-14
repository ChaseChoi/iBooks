//
//  SalesDataSource.swift
//  iBooks
//
//  Created by Chase Choi on 13/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation

/// maintain the cart list
class SalesDataSource {
    var cartList: [Book] = []
    
    ///add the book to data source; if repeat, return false, otherwise, true
    func add(book: Book) -> Bool {
        
        for i in 0 ..< cartList.count {
            if book.isbn == cartList[i].isbn {
                cartList[i].changeNumberOfBooks(number: 1)
                return false;
            }
        }
        cartList.append(book)
        return true
    }
    func getBookItem(at indexPath: IndexPath) -> Book {
        return cartList[indexPath.row]
    }
    func deleteBook(at indexPath: IndexPath) {
        cartList.remove(at: indexPath.row)
    }
    
    func getNumOfItems() -> Int {
        return cartList.count
    }
    
    func fetchBookFromDatabase(with isbn: String) -> Book? {
        if let book = try? AppDatabase.getBook(with: isbn) {
            return book
        }
        return nil
    }
    
    /// remove all the items in the cart list
    func emptyCart() {
        cartList.removeAll()
    }
    
    func getAmount() -> Double {
        var amount = 0.0
        for book in cartList {
            amount += book.price * Double(book.number)
        }
        return amount
    }
    
}
