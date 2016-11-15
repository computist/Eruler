//
//  MainCameraViewController.swift
//  AccTest
//
//  Created by Wang Haonan on 10/11/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit
import CameraManager


class MainCameraViewController: UIViewController {
    let cameraManager = CameraManager()
    
    @IBOutlet weak var cross: crossView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    
    let measure = Displacement()
    
    var image1: UIImage? = nil
    var image2: UIImage? = nil
    //var crossStart: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cameraManager.addPreviewLayerToView(previewView)
        cameraManager.cameraOutputMode = .videoOnly
        cameraManager.cameraOutputQuality = .high
        cameraManager.writeFilesToPhoneLibrary = false
        cameraManager.flashMode = .off
//        cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
//            print("hi")
//        })
    }
    @IBAction func measureClick(_ sender: UIButton) {
        if (measure.isStarted()) {
            // end
            //crossStart = !crossStart
            cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
                self.image2 = image
                
                var result: Double = 0.0
                result = self.measure.end()
                self.distanceLabel.text = "\(result)"
                self.clickButton.setTitle("Start", for: .normal)
                
                let imageShowController = ShowImagesViewController()
                imageShowController.image1 = self.image1
                imageShowController.image2 = self.image2
                imageShowController.displacement = result
                self.present(imageShowController, animated: true, completion: nil)
            })
        } else {
            // start
            cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
                self.image1 = image
                self.measure.start()
                self.distanceLabel.text = ""
                self.clickButton.setTitle("Stop", for: .normal)
                self.cross.gx1 = self.measure.gx1//
                self.cross.gy1 = self.measure.gy1//
                self.cross.gz1 = self.measure.gz1//
                
            })
        
                self.cross.gx2 = self.measure.gx2//
                self.cross.gy2 = self.measure.gy2//
                self.cross.gz2 = self.measure.gz2//
        }
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        cameraManager.resumeCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.stopCaptureSession()
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
