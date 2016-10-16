//
//  Displacement.swift
//  AccTest
//
//  Created by Wang Haonan on 10/15/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit
import CoreMotion

class Displacement: NSObject {
    let Manager = CMMotionManager()
    
//    let gxSmoother = Smoother(length: 10)
//    let gySmoother = Smoother(length: 10)
//    let gzSmoother = Smoother(length: 10)
    
    let axSmoother = Smoother(length: 10)
    let aySmoother = Smoother(length: 10)
    let azSmoother = Smoother(length: 10)
    
    var started: Bool = false
    var dx: Double = 0.0
    var vx: Double = 0.0
    var vy: Double = 0.0
    var vz: Double = 0.0
    let dt: Double = 0.01
    var vxData:[Double] = []
    var vyData:[Double] = []
    var vzData:[Double] = []
    
    func computeDistance(data: [Double]) -> Double? {
        var data = data
        let curveFactor = 1.001
        let stableFactor = 0.001
        
        var max = data.max()!
        var min = data.min()!
        
        
        // TODO if min > 0
        var negative: Double = 1
        let diff = -min
        
        let maxIdx = data.index(of: max)!
        var startIdx: Int = 0
        for i in 1...data.count - 1 {
            if (data[i] > stableFactor) {
                startIdx = i
                break
            }
        }
        
        if startIdx == 0 {
            return nil
        }
        
        
        // fix data after maxIdx
        for i in maxIdx - 1...data.count - 1 {
            data[i] += diff
        }
        
        // fix between startIdx and maxIdx-1
        let ratio = (max + diff) / max - 1
        for i in startIdx - 1...maxIdx - 2 {
            data[i] *= (pow(curveFactor, Double(i)) - 1) / (pow(curveFactor, Double(maxIdx - startIdx)) - 1) * ratio + 1
        }
        
        // calculate result
        var result: Double = 0;
        for i in 0...data.count-1 {
            result += data[i] * dt
        }
        return result * negative
    }
    
    func end() -> Double {
        var result: Double = 0.0
        if (started) {
            started = !started
            Manager.stopDeviceMotionUpdates()
            
            if let computeValue = computeDistance(data: vyData) {
                result = computeValue * 9.81 * 100.0
            }
            
            dx = 0
            vx = 0
            vy = 0
            vz = 0
            
            vxData.removeAll()
            vyData.removeAll()
            vzData.removeAll()
        }
        return result
    }
    
    func start() {
        if (!started) {
            started = !started
            Manager.startDeviceMotionUpdates(using: .xTrueNorthZVertical)
            Manager.deviceMotionUpdateInterval = dt
            Manager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler:{
                deviceManager, error in
                //Do stuffs with deviceManager or with error
                if (deviceManager != nil) {
                    //                self.gxSmoother.updateValue(value: deviceManager!.gravity.x)
                    //                self.gySmoother.updateValue(value: deviceManager!.gravity.y)
                    //                self.gzSmoother.updateValue(value: deviceManager!.gravity.z)
                    
                    self.axSmoother.updateValue(value: deviceManager!.userAcceleration.x)
                    self.aySmoother.updateValue(value: deviceManager!.userAcceleration.y)
                    self.azSmoother.updateValue(value: deviceManager!.userAcceleration.z)
                    
                    self.vx+=(self.axSmoother.getLastValue() + self.axSmoother.getValue())/2.0*self.dt
                    self.vxData.append(self.vx)
                    
                    self.vy+=(self.aySmoother.getLastValue() + self.aySmoother.getValue())/2.0*self.dt
                    self.vyData.append(self.vy)
                    
                    self.vz+=(self.azSmoother.getLastValue() + self.axSmoother.getValue())/2.0*self.dt
                    self.vzData.append(self.vz)
                }
            })
        }
    }
    
    func isStarted() -> Bool {
        return started
    }
}
