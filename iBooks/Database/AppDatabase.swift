//
//  AppDatabase.swift
//  iBooks
//
//  Created by Chase Choi on 11/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation
import GRDB

struct AppDatabase {
    
    static func openDatabase(at path: String) throws -> DatabaseQueue{
        dbQueue = try DatabaseQueue(path: path)
        return dbQueue
    }
    
    static func create(table: SQLTable.Type) throws {
        try dbQueue.inDatabase { db in
            try db.execute(table.createStatement)
        }
    }
    
    static func insertBook(named book: Book) -> Bool{
        // check if uid repeat
        let count = try? dbQueue.inDatabase { db in
            try Int.fetchOne(db, """
                SELECT COUNT(*) FROM \(tableName.Books.rawValue)
                where isbn == \(book.isbn)
                """)!
        }
        if count != 0 {
            return false
        } else {
            try! dbQueue.inDatabase { db in
                try db.execute("""
                    insert into \(tableName.Books.rawValue)
                    (isbn, imageURL, title, authors, price, categories, publisher, number)
                    values(?, ?, ?, ?, ?, ?, ?, ?)
                    """, arguments: [book.isbn, book.imageURL?.absoluteString, book.title, book.authors, book.price, book.categories, book.publisher, book.number])
            }
            return true
        }
    
    }
    
    static func getBook(with isbn: String) throws -> Book? {
        var book: Book?
        try dbQueue.inDatabase { db in
            book = try Book.fetchOne(db, key: isbn)
        }
        return book
    }
    static func getAllBooks() throws -> [Book]? {
        var books: [Book]?
        try dbQueue.inDatabase { db in
            books = try Book.fetchAll(db, "select * from \(tableName.Books.rawValue)")
        }
        return books
    }
    
    static func getAllUsers() throws -> [User]? {
        var userList: [User]?
        try dbQueue.inDatabase { db in
            userList = try User.fetchAll(db, "select * from \(tableName.Users.rawValue)")
        }
        return userList
    }
}
