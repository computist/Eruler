//
//  ShowImagesViewController.swift
//  AccTest
//
//  Created by Wang Haonan on 10/15/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit

class ShowImagesViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var image1: UIImage? = nil
    var image2: UIImage? = nil
    var displacement: Double = 0.0
    
    @IBAction func OKClick(_ sender: UIButton) {
        imageView.image = image2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView.image = image1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
