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
    
    func getTitle() -> String {
        return volumeInfo.title
    }
    func getPublisher() -> String? {
        if let publisher = volumeInfo.publisher {
            return publisher
        }
        return nil
    }
    func getAuthors() -> String? {
        if let authors = volumeInfo.authors {
            let authorList = authors.joined(separator: ", ")
            return authorList
        }
        return nil
    }
    func getISBN_13() -> String {
        if volumeInfo.industryIdentifiers[0].type == "ISBN_13" {
            return volumeInfo.industryIdentifiers[0].identifier
        } else {
            return volumeInfo.industryIdentifiers[1].identifier
        }
    }
    func getImageUrl() -> URL? {
        if let url = volumeInfo.imageLinks?.thumbnail {
            return url
        }
        return nil
    }
    func getCategories() -> String? {
        if let categoryArray = volumeInfo.categories {
            let categories = categoryArray.joined(separator: ", ")
            return categories
        }
        return nil
    }
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

