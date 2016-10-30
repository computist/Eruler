//
//  CalculationViewController.swift
//  AccTest
//
//  Created by Wang Haonan on 10/29/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit

class CalculationViewController: UIViewController {
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    
    var displacement: Double = 0.0
    var l1x1: CGFloat = 0.0
    var l1y1: CGFloat = 0.0
    var l1x2: CGFloat = 0.0
    var l1y2: CGFloat = 0.0
    var l2x1: CGFloat = 0.0
    var l2y1: CGFloat = 0.0
    var l2x2: CGFloat = 0.0
    var l2y2: CGFloat = 0.0
    
    var length: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lengthLabel.text = String(self.displacement)
        
        let length1 = sqrt(pow((l1x1-l1x2),2)+pow((l1y1-l1y2),2))
        let pDisplacement = abs(l1y1-l2y1)
        //let measurement = displacement / Double(pDisplacement) * Double(length1)
        let measurement = 20.0 / Double(pDisplacement) * Double(length1)
        mLabel.text = String(measurement)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
