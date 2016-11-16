//
//  ShowImagesViewController.swift
//  AccTest
//
//  Created by Wang Haonan on 10/15/16.
//  Copyright © 2016 Wang Haonan. All rights reserved.
//

import UIKit
import iOS_MagnifyingGlass

class ShowImagesViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var displayLine: DisplayImageView!
    
    var image1: UIImage? = nil
    var image2: UIImage? = nil
    var displacement: Double = 0.0
    
    var Img1x1: CGFloat = 0.0
    var Img1y1: CGFloat = 0.0
    var Img1x2: CGFloat = 0.0
    var Img1y2: CGFloat = 0.0
    
    var Img2x1: CGFloat = 0.0
    var Img2y1: CGFloat = 0.0
    var Img2x2: CGFloat = 0.0
    var Img2y2: CGFloat = 0.0
    
    var finished: Bool = false
    
    @IBAction func OKClick(_ sender: UIButton) {
        if(!finished){
            self.Img1x1 = displayLine.x1
            self.Img1y1 = displayLine.y1
            self.Img1x2 = displayLine.x2
            self.Img1y2 = displayLine.y2
            print("get Image1 x1 \(self.Img1x1),y1 \(self.Img1y1),x2 \(self.Img1x2),y2 \(Img1y2)")
            let newImg2 = cropToBounds(image: image2!)
            imageView.image = newImg2
            finished = !finished
        }else{
            self.Img2x1 = displayLine.x1
            self.Img2y1 = displayLine.y1
            self.Img2x2 = displayLine.x2
            self.Img2y2 = displayLine.y2
            print("get Image2 x1 \(self.Img2x1),y1 \(self.Img2y1),x2 \(self.Img2x2),y2 \(Img2y2)")
            let calViewController = CalculationViewController()
            calViewController.displacement = self.displacement
            calViewController.l1x1 = self.Img1x1
            calViewController.l1y1 = self.Img1y1
            calViewController.l1x2 = self.Img1x2
            calViewController.l1y2 = self.Img1y2
            calViewController.l2x1 = self.Img2x1
            calViewController.l2y1 = self.Img2y1
            calViewController.l2x2 = self.Img2x2
            calViewController.l2y2 = self.Img2y2
            self.present(calViewController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let newImg1 = cropToBounds(image: image1!)
        imageView.image = newImg1
        
        displayLine.isOpaque = false
        
        let mag: ACMagnifyingGlass = ACMagnifyingGlass(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        mag.scale = 2;
        displayLine.magnifyingGlass = mag
        displayLine.magnifyingGlassShowDelay = 0
        displayLine.updateBackgroundImage(imageView)
    }
    
    func cropToBounds(image: UIImage) -> UIImage {
        
        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)

        let cgwidth: CGFloat = image.size.height/16*9
        let cgheight: CGFloat = image.size.height
        let posX: CGFloat = 0
        let posY: CGFloat = (image.size.width - cgwidth) / 2
        

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgheight, height: cgwidth)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        return image
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
