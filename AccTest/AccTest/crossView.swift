//
//  crossView.swift
//  AccTest
//
//  Created by Wang Haonan on 11/14/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//
import UIKit

class CrossView: UIView {
//    var gx1: Double = 0.0
//    var gy1: Double = 0.0
//    var gz1: Double = 0.0
//    
//    var gx2: Double = 0.0
//    var gy2: Double = 0.0
//    var gz2: Double = 0.0
    let threshold = 0.025
    
    
    var l1x1: CGFloat = 0
    var l1y1: CGFloat = 50
    var l1x2: CGFloat = 100
    var l1y2: CGFloat = 50
    
    var l2x1: CGFloat = 50
    var l2y1: CGFloat = 0
    var l2x2: CGFloat = 50
    var l2y2: CGFloat = 100
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
        
        if (abs(measure.gx1 - measure.gx2) < threshold && abs(measure.gy1 - measure.gy2) < threshold && abs(measure.gz1 - measure.gz2) < threshold){
            UIColor.green.set()
        } else {
            UIColor.red.set()
        }
        aPath.stroke()
        bPath.stroke()
        //If you want to fill it as well
        aPath.fill()
        bPath.fill()
        
        let centerX = 50 + (measure.gx2 - measure.gx1) * 50
        let centerY = 50 + (measure.gy2 - measure.gy1) * 50
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX,y: centerY), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        circlePath.stroke()
    }
 

}
