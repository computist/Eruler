//
//  KalmanFilter.swift
//  AccTest
//
//  Created by Wang Haonan on 10/9/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit

class KalmanFilter: NSObject {
    // kalman filtering
    var q = 0.1   // process noise
    var r = 0.1   // sensor noise
    var p = 0.1   // estimated error
    var k = 0.5   // kalman filter gain
    
    var lv: Double = 0.0
    
    func filter(value: Double) -> Double {
        lv = value
        p = p + q
        k = p / (p + r)
        lv = lv + k * (value - lv)
        p = (1 - k) * p
        return lv
    }
    
    func getLastValue() -> Double {
        return lv;
    }
    
    func reset() {
        q = 0.1   // process noise
        r = 0.1   // sensor noise
        p = 0.1   // estimated error
        k = 0.5   // kalman filter gain
    }
}
