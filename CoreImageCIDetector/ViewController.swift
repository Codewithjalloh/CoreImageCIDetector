//
//  ViewController.swift
//  CoreImageCIDetector
//
//  Created by wealthyjalloh on 30/07/2016.
//  Copyright © 2016 CWJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // properties
    var filePath: NSString = ""
    var fileNameAndPath = NSURL()
    var image = CIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        filePath = NSBundle.mainBundle().pathForResource("emotions", ofType: "jpg")!
        fileNameAndPath = NSURL.fileURLWithPath(filePath as String)
        image = CIImage(contentsOfURL: fileNameAndPath)!
        
        let context = CIContext(options: nil)
        let options = NSDictionary(object: CIDetectorAccuracyHigh, forKey: CIDetectorAccuracy)
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options as? [String: AnyObject])
        let features: NSArray = detector.featuresInImage(image, options: [CIDetectorSmile:true, CIDetectorEyeBlink:true])
        let imgView = UIImageView(image: UIImage(named: "emotions.jpg"))
        self.view.addSubview(imgView)
        
        // aux view to invert 
        let vistAux = UIView(frame: imgView.frame)
        for faceFeature in features {
            
            //Detection 
            let smile = faceFeature.hasSmile
            let rightEyeBlinking = faceFeature.rightEyeClosed
            let leftedBlinking = faceFeature.leftEyeClosed
            
            //face location 
            let faceRect = faceFeature.bounds
            let faceView = UIView(frame: faceRect)
            faceView.layer.borderWidth = 2
            faceView.layer.borderColor = UIColor.redColor().CGColor
            
            let faceWidth: CGFloat = faceRect.size.width
            let faceHeight: CGFloat = faceRect.size.height
            vistAux.addSubview(faceView)
            
            
            
            
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

