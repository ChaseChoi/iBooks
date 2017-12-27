//
//  googleDataSource.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

// secrect key: AIzaSyCA9Y_caECNgef4hfVvzkZmqftIgs7Nlw4
// url: 9787508630922
import Foundation

class googleDataSource {
    static func loadJSON(isbn: String) -> [[String: AnyObject]] {
        var items = [[String:AnyObject]]()
        
        let jsonUrlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyCA9Y_caECNgef4hfVvzkZmqftIgs7Nlw4"
        
        guard let url = URL(string: jsonUrlString) else {
            print("URL ERROR!")
            return [[:]]
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject] else {
                    return
                }
        
                if let bookInfo = json["items"] as? [[String:AnyObject]] {
                    let item = bookInfo as [[String:AnyObject]]
                    print(item[0]["volumeInfo"]!["authors"])
                    print(item[0]["volumeInfo"]!["title"])
                    print(item[0]["volumeInfo"]!["publisher"])
                }
            } catch let jsonErr {
                print("Json error:", jsonErr)
            }
            }.resume()
        return items
    }
    
}
