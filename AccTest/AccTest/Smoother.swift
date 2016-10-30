//
//  Smoother.swift
//  AccTest
//
//  Created by Wang Haonan on 10/8/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit

class Smoother: NSObject {
    var valueArray: [Double]
    let length: Int
    var lastValue: Double = 0
    var pos: Int = 0
    var sum: Double = 0
    
    init(length: Int) {
        valueArray = [Double] (repeating: 0.00, count: length)
        self.length = length
    }
    
    func getValue() -> Double {
        return sum / Double(length)
    }
    
    func getLastValue() -> Double {
        return lastValue
    }
    
    func updateValue(value: Double) {
        lastValue = getValue()
        sum += (value - valueArray[pos])
        valueArray[pos] = value
        pos = (pos + 1) % length
    }
    
    func reset() {
        lastValue = 0
        pos = 0
        sum = 0
        valueArray = [Double] (repeating: 0.00, count: length)
    }
}
