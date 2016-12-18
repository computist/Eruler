//
//  MainCameraViewController.swift
//  AccTest
//
//  Created by Wang Haonan on 10/11/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit
import CameraManager

let measure = Displacement()

class MainCameraViewController: UIViewController {
    let cameraManager = CameraManager()
    
    @IBOutlet weak var cross: CrossView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    
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
        measure.cv = cross
        
        cross.parent = self
    }
    
    func captureSecond() {
        
        measure.Manager.stopDeviceMotionUpdates()
        
        cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
            self.image2 = image
            
            self.clickButton.setTitle("Start", for: .normal)
            
            let imageShowController = ShowImagesViewController()
            imageShowController.image1 = self.image1
            imageShowController.image2 = self.image2
            imageShowController.displacement = measure.end()
            self.present(imageShowController, animated: true, completion: nil)
        })
    }
    @IBAction func measureClick(_ sender: UIButton) {
        if (measure.isStarted()) {
            // end
            //crossStart = !crossStart
            var result: Double = 0.0
            result = measure.end()
            self.distanceLabel.text = "\(result)"
            self.clickButton.setTitle("Waiting", for: .normal)
            cross.needCapture = true
        } else {
            // start
            cameraManager.capturePictureWithCompletion({ (image, error) -> Void in
                self.image1 = image
                measure.start()
                self.distanceLabel.text = ""
                self.clickButton.setTitle("Stop", for: .normal)
                
            })
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
