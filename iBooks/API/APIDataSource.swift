//
//  APIDataSource.swift
//  iBooks
//
//  Created by Chase Choi on 06/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

// secrect key: AIzaSyCA9Y_caECNgef4hfVvzkZmqftIgs7Nlw4
// url: 9787508630922
import Foundation

class APIDataSource {
    static func loadJSON(isbn: String, completion: @escaping (Book?, Bool) -> ()) {
        let jsonUrlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyCA9Y_caECNgef4hfVvzkZmqftIgs7Nlw4"
        var status = false
        
        guard let url = URL(string: jsonUrlString) else {
            print("URL ERROR!")
            status = false
            completion(nil, status)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            var bookItem: Book?

            guard let data = data else {
                status = false
                completion(bookItem, status)
                return
            }
            do {
                let apiData = try JSONDecoder().decode(APIData.self, from: data)
                
                if apiData.totalItems != 0 {
                    bookItem = Book(data: apiData)
                    status = true
                }
            } catch let jsonErr {
                status = false
                print("Json error:", jsonErr)
            }
            completion(bookItem, status)
            }.resume()
        
        
    }
    
}

