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
        let user0 = User(uid: "124124", name: "Chase", vip: "0", phone: "124214124", amount: "124.0")
        userList.append(user0)
        let user1 = User(uid: "121224", name: "Cindy", vip: "1", phone: "124214124", amount: "244.0")
        userList.append(user1)
        let user2 = User(uid: "221224", name: "Cindy", vip: "1", phone: "124214124", amount: "244.0")
        userList.append(user2)
        let user3 = User(uid: "331224", name: "Cindy", vip: "1", phone: "124214124", amount: "244.0")
        userList.append(user3)
        let user4 = User(uid: "521224", name: "Cindy", vip: "1", phone: "124214124", amount: "244.0")
        userList.append(user4)
        let user5 = User(uid: "341224", name: "John", vip: "2", phone: "124214124", amount: "244.0")
        userList.append(user5)
    }
    
    func add(user: User) {
        userList.append(user)
    }
    func deleteUser(at index: IndexPath) {
        userList.remove(at: index.row)
    }
}
