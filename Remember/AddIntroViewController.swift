//
//  AddIntroViewController.swift
//  Remember
//
//  Created by Joey on 11/11/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AddIntroViewController: UIViewController{
    
    @IBOutlet weak var tutorialContainer: UIView!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var addPhotoButton: UIImageView!
    
    @IBOutlet weak var grayView1: UIView!
    @IBOutlet weak var grayView2: UIView!
    @IBOutlet weak var grayView3: UIView!
    @IBOutlet weak var grayView4: UIView!
    
    var animationTimer = NSTimer()
    
    override func viewDidLoad() {
        image1.alpha = 0.0
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        animate()
    }
    
    func animate(){
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: {
                self.addPhotoButton.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: {finished in
                UIView.animateWithDuration(0.2, animations: {
                        self.addPhotoButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    }, completion: {finished in
                        UIView.animateWithDuration(0.4, animations: {
                                self.image1.alpha = 1.0
                            }, completion: {finished in
                                UIView.animateWithDuration(0.5, delay: 0.4, options: [], animations: {
                                    self.grayView1.transform = CGAffineTransformMakeTranslation(200, 0)
                                    }, completion: {finished in
                                        UIView.animateWithDuration(0.5, animations: {
                                            self.grayView2.transform = CGAffineTransformMakeTranslation(200, 0)
                                            }, completion: {finished in
                                                UIView.animateWithDuration(0.5, animations: {
                                                    self.grayView3.transform = CGAffineTransformMakeTranslation(200, 0)
                                                    }, completion: {finished in
                                                        UIView.animateWithDuration(0.5, animations: {
                                                            self.grayView4.transform = CGAffineTransformMakeTranslation(200, 0)
                                                            }, completion: {finished in
                                                                UIView.animateWithDuration(0.5, animations: {
                                                                    self.grayView1.transform = CGAffineTransformMakeTranslation(0, 0)
                                                                    self.grayView2.transform = CGAffineTransformMakeTranslation(0, 0)
                                                                    self.grayView3.transform = CGAffineTransformMakeTranslation(0, 0)
                                                                    self.grayView4.transform = CGAffineTransformMakeTranslation(0, 0)
                                                                    self.image1.alpha = 0.0
                                                                    }, completion: {finished in
                                                                        self.startTimer()
                                                                })
                                                        })
                                                })
                                        })
                                })
                        })
                })
        })
    }
    
    func startTimer(){
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: "animate", userInfo: nil, repeats: false)
    }
    
    
}