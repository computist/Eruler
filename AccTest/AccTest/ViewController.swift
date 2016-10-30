//
//  ViewController.swift
//  AccTest
//
//  Created by Wang Haonan on 10/6/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit
import CoreMotion
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var value2Label: UILabel!
    @IBOutlet weak var value3Label: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    let Manager = CMMotionManager()
    let baroManager = CMAltimeter()
    
    let gxSmoother = Smoother(length: 10)
    let gySmoother = Smoother(length: 10)
    let gzSmoother = Smoother(length: 10)
    
    let axSmoother = Smoother(length: 10)
    let aySmoother = Smoother(length: 10)
    let azSmoother = Smoother(length: 10)
    
    let baroSmoother = Smoother(length: 10)
    
    var started: Bool = false
    var dx: Double = 0.0
    var vx: Double = 0.0
    var vy: Double = 0.0
    var vz: Double = 0.0
    let dt: Double = 0.01
    var vxData:[Double] = []
    var vyData:[Double] = []
    var vzData:[Double] = []
    
    let baroFilter: KalmanFilter = KalmanFilter()
    let baroDistFilter: KalmanFilter = KalmanFilter()
    
    func sendEmail(data: Data, resultInCm: Double) {
        let mailViewController = MFMailComposeViewController()

        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("Data")
        mailViewController.setMessageBody("Result length is \(resultInCm)cm.", isHTML: false)
        mailViewController.addAttachmentData(data, mimeType: "text/plain", fileName: "output.txt")
        self.present(mailViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func computeDistance(data: [Double]) -> Double? {
        var data = data
        let curveFactor = 1.001
        let stableFactor = 0.001
        
        let max = data.max()!
        let min = data.min()!
        
        
        // TODO if min > 0
        let negative: Double = 1
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

    @IBAction func startClick(_ sender: UIButton) {
        if (started) {
            Manager.stopDeviceMotionUpdates()
            startButton.setTitle("Start", for: .normal)
            if let computeValue = computeDistance(data: vyData) {
                let result = computeValue * 9.81 * 100
                distanceLabel.text = "\(result)"
            } else {
                let alert = UIAlertController(title: "Alert", message: "Try again. Stable your camera in the beginning and the end.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            dx = 0
            vx = 0
            vy = 0
            vz = 0
            
//            sendEmail(data: axData.map(String.init).joined(separator: "\n").data(using: String.Encoding.utf8)!, resultInCm: result)
            vxData.removeAll()
            vyData.removeAll()
            vzData.removeAll()
            
        } else {
            distanceLabel.text = ""
            startButton.setTitle("Stop", for: .normal)
            
            Manager.startDeviceMotionUpdates(using: .xTrueNorthZVertical)
            Manager.deviceMotionUpdateInterval = dt
            Manager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler:{
                deviceManager, error in
                //Do stuffs with deviceManager or with error
                if (deviceManager != nil) {
                    self.gxSmoother.updateValue(value: deviceManager!.gravity.x)
                    self.gySmoother.updateValue(value: deviceManager!.gravity.y)
                    self.gzSmoother.updateValue(value: deviceManager!.gravity.z)
                    
                    self.axSmoother.updateValue(value: deviceManager!.userAcceleration.x)
                    self.aySmoother.updateValue(value: deviceManager!.userAcceleration.y)
                    self.azSmoother.updateValue(value: deviceManager!.userAcceleration.z)
                    
                    
                    if (self.started) {
                        self.vx+=(self.axSmoother.getLastValue() + self.axSmoother.getValue())/2.0*self.dt
                        self.vxData.append(self.vx)
                        
                        self.vy+=(self.aySmoother.getLastValue() + self.aySmoother.getValue())/2.0*self.dt
                        self.vyData.append(self.vy)
                        
                        self.vz+=(self.azSmoother.getLastValue() + self.axSmoother.getValue())/2.0*self.dt
                        self.vzData.append(self.vz)
                    }
                    
                    self.valueLabel.text = String(format:"%.3f, %.3f, %.3f", self.gxSmoother.getValue(), self.gySmoother.getValue(), self.gzSmoother.getValue())
                    
                    self.value2Label.text = String(format:"%.3f, %.3f, %.3f", /*self.axFilter.getLastValue()*/self.axSmoother.getValue(), self.aySmoother.getValue(), self.azSmoother.getValue())
                }
            })
        }
        started = !started
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

