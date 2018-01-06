//
//  APIData.swift
//  iBooks
//
//  Created by Chase Choi on 06/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation

struct APIData: Codable {
    let totalItems: Int
    let items: [BookInfo]?
}

struct BookInfo: Codable {
    let volumeInfo: VolumeInfo
}
struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let industryIdentifiers: [IndustryID]
    let categories: [String]?
    let imageLinks: Link?
}

struct Link:Codable {
    let thumbnail: URL
}

struct IndustryID: Codable {
    let type: String
    let identifier: String
}

