//
//  DisplayImageView.swift
//  AccTest
//
//  Created by Wang Haonan on 10/15/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit

class DisplayImageView: UIView {
    
    var x1: CGFloat = 200
    var y1: CGFloat = 200
    var x2: CGFloat = 200
    var y2: CGFloat = 300
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:x1, y:y1))
        
        aPath.addLine(to: CGPoint(x:x2, y:y2))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.red.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        let disSq1 = pow((location.x - x1), 2) + pow((location.y - y1), 2)
        let disSq2 = pow((location.x - x2), 2) + pow((location.y - y2), 2)
        
        if (disSq1 < 400) {
            x1 = location.x
            y1 = location.y
            print("\(location.x), \(location.y)")
            self.setNeedsDisplay()
        } else if (disSq2 < 400) {
            x2 = location.x
            y2 = location.y
            print("\(location.x), \(location.y)")
            self.setNeedsDisplay()
        }
    }
}
