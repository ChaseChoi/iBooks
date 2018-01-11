//
//  SQLiteDatabase.swift
//  iBooks
//
//  Created by Chase Choi on 09/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation
import SQLite3
import GRDB

enum SQLiteError: Error {
    case OpenDatabase(msg: String)
    case Prepare(msg: String)
    case Step(msg: String)
    case Bind(msg: String)
}
class SQLiteDatabase {
    fileprivate let databasePointer: OpaquePointer?
    
    var errorMessage: String {
        if let errorPointer = sqlite3_errmsg(databasePointer) {
            let errorMsg = String.init(cString: errorPointer)
            return errorMsg
        } else {
            return "No error message provided from SQLite!"
        }
    }
    
    fileprivate init(dbPointer: OpaquePointer?) {
        databasePointer = dbPointer
    }
    
    deinit {
        sqlite3_close(databasePointer)
    }
    
    static func open(path: String) throws -> SQLiteDatabase {
        var database: OpaquePointer?
        
        // check path; if true, return Database instance
        if sqlite3_open(path, &database) == SQLITE_OK {
            return SQLiteDatabase(dbPointer: database)
        } else {
            // clean up
            defer {
                if database != nil {
                    sqlite3_close(database)
                }
            }
        }
        
        // check the type of error and throw
        if let errorPointer = sqlite3_errmsg(database) {
            let msg = String.init(cString: errorPointer)
            throw SQLiteError.OpenDatabase(msg: msg)
        } else {
            throw SQLiteError.OpenDatabase(msg: "No error message provided from SQLite!")
        }
        
    }
    
    class func safeType(object: AnyObject?) -> AnyObject{
        if let safeObject = object {
            return safeObject
        }
        return NSNull()
    }
}

extension SQLiteDatabase {
    func prepare(sql statement: String) throws -> OpaquePointer? {
        var compiledStatement: OpaquePointer?
        guard sqlite3_prepare_v2(databasePointer, statement, -1, &compiledStatement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(msg: errorMessage)
        }
        return compiledStatement
    }
}

extension SQLiteDatabase {
    func createTable(table: SQLTable.Type) throws {
        let createTableStatement = try prepare(sql: table.createStatement)
        
        // clean up
        defer {
            sqlite3_finalize(createTableStatement)
        }
        
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(msg: errorMessage)
        }
        print("table created successfully!")
    }
    
    // insert statement
    func insertBook(named book: Book) throws {
        // use question mark to enhance performance
        let insertSQL = """
        insert into \(tableName.Books.rawValue)
        (ISBN, ImageURL, Title, Authors, Price, Categories, Publisher, Number)
        values(?, ?, ?, ?, ?, ?, ?, ?);
        """
        // compile statement
        let insertStatement = try prepare(sql: insertSQL)
        
        defer {
            sqlite3_finalize(insertStatement)
        }
        
        // sql statement
        guard sqlite3_bind_text(insertStatement, 1, book.isbn, -1, nil) == SQLITE_OK
            && sqlite3_bind_text(insertStatement, 2, SQLiteDatabase.safeType(object: book.imageURL as AnyObject) as! UnsafePointer<Int8>, -1, nil) == SQLITE_OK
            && sqlite3_bind_text(insertStatement, 3, book.title, -1, nil) == SQLITE_OK
            && sqlite3_bind_text(insertStatement, 4, book.authors, -1, nil) == SQLITE_OK
            && sqlite3_bind_double(insertStatement, 5, book.price) == SQLITE_OK
            && sqlite3_bind_text(insertStatement, 6, book.categories, -1, nil) == SQLITE_OK
            && sqlite3_bind_text(insertStatement, 7, book.publisher, -1, nil) == SQLITE_OK
            && sqlite3_bind_int(insertStatement, 8, Int32(book.number)) == SQLITE_OK   else {
            throw SQLiteError.Bind(msg: errorMessage)
        }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(msg: errorMessage)
        }
        print("Successfully inserted row.")
    }
    
    // TODO: - return a book
    func getBook(with isbn: String) {
        let query = """
        select * from \(tableName.Books.rawValue)
        where ISBN = ?
        """
        guard let queryStatement = try? prepare(sql: query) else {
            return
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        // complete the question mark
        guard sqlite3_bind_text(queryStatement, 1, isbn, -1, nil) == SQLITE_OK else {
            return
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return
        }
        
        let resultCol1 = sqlite3_column_text(queryStatement, 1)
        let imageURL = URL.init(string: (String(describing: resultCol1)))
        print(imageURL?.absoluteString as Any)
        
        let resultCol2 = sqlite3_column_text(queryStatement, 2)
        let title  = String(describing: resultCol2)
        print(title)
        
    }
}
