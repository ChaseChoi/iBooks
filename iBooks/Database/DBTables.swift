//
//  DBTables.swift
//  iBooks
//
//  Created by Chase Choi on 11/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation

enum tableName: String {
    case Books
    case Users
    case DBAdmins
    case PaymentList
}

protocol SQLTable {
    static var createStatement: String {get}
}
