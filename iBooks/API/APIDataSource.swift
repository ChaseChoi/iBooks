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
    static func loadJSON(isbn: String) {
        
        let jsonUrlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)&key=AIzaSyCA9Y_caECNgef4hfVvzkZmqftIgs7Nlw4"
        
        guard let url = URL(string: jsonUrlString) else {
            print("URL ERROR!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else {
                return
            }
            do {
                let apiData = try JSONDecoder().decode(APIData.self, from: data)
                print(apiData.items as Any)
                print(apiData.totalItems)
            } catch let jsonErr {
                print("Json error:", jsonErr)
            }
            }.resume()
    }
    
}
