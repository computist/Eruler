//
//  crossView.swift
//  AccTest
//
//  Created by Wang Haonan on 11/14/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//
import UIKit

class crossView: UIView {
    var gx1: Double = 0.0
    var gy1: Double = 0.0
    var gz1: Double = 0.0
    
    var gx2: Double = 0.0
    var gy2: Double = 0.0
    var gz2: Double = 0.0
    
    var l1x1: CGFloat = 110
    var l1y1: CGFloat = 290
    var l1x2: CGFloat = 210
    var l1y2: CGFloat = 290
    
    var l2x1: CGFloat = 160
    var l2y1: CGFloat = 240
    var l2x2: CGFloat = 160
    var l2y2: CGFloat = 340
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        let aPath = UIBezierPath()
        let bPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:l1x1, y:l1y1))
        aPath.addLine(to: CGPoint(x:l1x2, y:l1y2))
        
        bPath.move(to: CGPoint(x:l2x1, y:l2y1))
        bPath.addLine(to: CGPoint(x:l2x2, y:l2y2))
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        bPath.close()
        //If you want to stroke it with a red color
        UIColor.red.set()
        aPath.stroke()
        bPath.stroke()
        //If you want to fill it as well
        aPath.fill()
        bPath.fill()
        if(abs(self.gx1-self.gx2)<0.50&&abs(self.gy1-self.gy2)<0.50&&abs(self.gz1-self.gz2)<0.50){
            UIColor.green.set()
            aPath.stroke()
            bPath.stroke()
            //If you want to fill it as well
            aPath.fill()
            bPath.fill()
        }
    }
 

}
