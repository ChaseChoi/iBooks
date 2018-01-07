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
    static func loadJSON(isbn: String, completion: @escaping (Book?) -> ()) {
        let jsonUrlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyCA9Y_caECNgef4hfVvzkZmqftIgs7Nlw4"
        
        guard let url = URL(string: jsonUrlString) else {
            print("URL ERROR!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            var bookItem: Book?
            
            guard let data = data else {
                return
            }
            do {
                let apiData = try JSONDecoder().decode(APIData.self, from: data)
                
                if apiData.totalItems != 0 {
                    bookItem = Book(data: apiData)
                }
            } catch let jsonErr {
                print("Json error:", jsonErr)
            }
            completion(bookItem)
            }.resume()
        
        
    }
    
}

