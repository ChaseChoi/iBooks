//
//  User.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import Foundation

struct User {
    var uid: String?
    var name: String?
    var vip: String?
    var phone: String?
    var amount: String?
}

extension User {
    init(uid: String, name: String, phone: String) {
        self.uid = uid
        self.name = name
        self.vip = "0"
        self.phone = phone
        self.amount = "0.0"
    }
}
