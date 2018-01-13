//
//  SalesDataSource.swift
//  iBooks
//
//  Created by Chase Choi on 13/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation

// maintain the cart list
class SalesDataSource {
    var cartList: [Book] = []
    
    
    func add(book: Book) {
        cartList.append(book)
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
}
