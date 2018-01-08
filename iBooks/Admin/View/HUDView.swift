//
//  HUDView.swift
//  iBooks
//
//  Created by Chase Choi on 08/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import UIKit

// ref: iOS apprentice tutorial 3 (version 5) p121
class HUDView: UIView {
    var text = ""
    
    class func hud(inView view: UIView, animated: Bool) -> HUDView {
        // find parent view's bounds
        let hudView = HUDView(frame: view.bounds)
        hudView.isOpaque = false
        
        view.addSubview(hudView)
        view.isUserInteractionEnabled = false
        hudView.show(animated: animated)
        return hudView
    }
    
    // draw the alert box
    override func draw(_ rect: CGRect) {
        let boxWidth: CGFloat = 96
        let boxHeight: CGFloat = 96
    
        // center the box
        let boxRect = CGRect(x: round( (bounds.size.width - boxWidth) / 2), y: round( (bounds.size.height - boxHeight) / 2), width: boxWidth, height: boxHeight)
        
        let roundedRect = UIBezierPath(roundedRect: boxRect, cornerRadius: 10)
        UIColor(white: 0.3, alpha: 0.8).setFill()
        roundedRect.fill()
        
        // add images to HUD
        if let image = UIImage(named: "checkmark") {
            let imagePoint = CGPoint(x: center.x - round(image.size.width / 2), y: center.y - round(image.size.height / 2) - boxHeight / 8)
            image.draw(at: imagePoint)
        }
        
        // add the text under the image
        let attr = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white ]
        let size = text.size(withAttributes: attr)
        
        let textPoint = CGPoint(x: center.x - round(size.width / 2), y: center.y - round(size.height / 2) + boxHeight / 4)
        text.draw(at: textPoint, withAttributes: attr)
        
    }
    
    // disappear with animation
    func show(animated: Bool) {
        if animated {
            // init state
            alpha = 0
            transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            // final state
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {self.alpha = 1
                self.transform = CGAffineTransform.identity
            }, completion: nil)
            
        }
    }
    
}
