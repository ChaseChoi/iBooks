//
//  UIImageViewDownloadImage.swift
//  iBooks
//
//  Created by Chase Choi on 08/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        
        URLSession.shared.dataTask(with: url){
            data, response, error in
            if error != nil {
                print("Failed to load image !")
                return
            }
            let image = UIImage(data: data!)
          
            DispatchQueue.main.async {
                self.image = image
            }
            
        }.resume()
        
    }
}


