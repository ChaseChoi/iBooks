//
//  UserDataSource.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import Foundation

class UserDataSource {
    var userList: [User] = []
    
    func getNumOfUsers() -> Int {
        return userList.count
    }
    
    func getUser(at indexPath: IndexPath) -> User {
        return userList[indexPath.row]
    }
    
    func fetch() {
        if let users = try! AppDatabase.getAllUsers() {
            userList = users
        } else {
            print("Empty user list")
        }
    }
    
    func add(user: User) -> Bool{
        // check if uid repeat
        let count = try! dbQueue.inDatabase { db in
            try Int.fetchOne(db, """
                SELECT COUNT(*) FROM \(tableName.Users.rawValue)
                where uid == \(user.uid)
                """)!
        }
        // repeat
        if count != 0 {
            return false
        } else {
            try! dbQueue.inDatabase { db in
                try user.insert(db)
            }
            userList.append(user)
            return true
        }
        
        
    }
    func deleteUser(at index: IndexPath) {
        let uid = userList[index.row].uid
        userList.remove(at: index.row)
        
        try! dbQueue.inDatabase { db in
            try db.execute("""
            delete from \(tableName.Users.rawValue)
            where uid == \(uid)
            """)
        }
    }
}
