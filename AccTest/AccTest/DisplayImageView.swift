//
//  DisplayImageView.swift
//  AccTest
//
//  Created by Wang Haonan on 10/15/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit
import iOS_MagnifyingGlass

class DisplayImageView : ACMagnifyingView {
    
    var x1: CGFloat = 200
    var y1: CGFloat = 200
    var x2: CGFloat = 200
    var y2: CGFloat = 300
    
    var selected = 0
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x:x1, y:y1))
        aPath.addLine(to: CGPoint(x:x2, y:y2))
        aPath.close()
        UIColor.red.set()
        aPath.stroke()
        aPath.fill()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let disSq1 = pow((location.x - x1), 2) + pow((location.y - y1), 2)
            let disSq2 = pow((location.x - x2), 2) + pow((location.y - y2), 2)
            if (disSq1 < 400) {
                super.touchesBegan(touches, with: event)
                selected = 1
                x1 = location.x
                y1 = location.y
                self.setNeedsDisplay()
            } else if (disSq2 < 400) {
                super.touchesBegan(touches, with: event)
                selected = 2
                x2 = location.x
                y2 = location.y
                self.setNeedsDisplay()
            } else {
                selected = 0
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if (selected == 1) {
                super.touchesMoved(touches, with: event)
                x1 = location.x
                y1 = location.y
                self.setNeedsDisplay()
            } else if (selected == 2) {
                super.touchesMoved(touches, with: event)
                x2 = location.x
                y2 = location.y
                self.setNeedsDisplay()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (selected != 0) {
            super.touchesEnded(touches, with: event)
            selected = 0
        }
    }
}
