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
    @IBOutlet weak var quote: UIImageView!
    @IBOutlet weak var fadeView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var addPhotoButton: UIImageView!
    
    @IBOutlet weak var grayView1: UIView!
    @IBOutlet weak var grayView2: UIView!
    @IBOutlet weak var grayView3: UIView!
    @IBOutlet weak var grayView4: UIView!
    
    var animationBegun = false
    var animationTimer = NSTimer()
    
    override func viewDidLoad() {
        image1.alpha = 0.0
        
        self.tutorialContainer.layer.cornerRadius = 5.0
        self.fadeView.backgroundColor = UIColor.clearColor()
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = fadeView.bounds
        fadeView.addSubview(visualEffectView)
        
        
        self.tutorialContainer.alpha = 0.0
        self.quote.alpha = 0.0
        self.fadeView.alpha = 0.0
        self.startButton.alpha = 0.0
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if animationBegun{
            fadeIn()
        }
        else{
            fadeIn({self.animate()})
            animationBegun = true
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.tutorialContainer.alpha = 0.0
        self.quote.alpha = 0.0
        self.fadeView.alpha = 0.0
        self.startButton.alpha = 0.0
    }
    
    func fadeIn(){
        UIView.animateWithDuration(1.0, delay: 0.3, options: [], animations: {
            self.quote.alpha = 1.0
            self.tutorialContainer.alpha = 1.0
            self.fadeView.alpha = 0.75
            self.startButton.alpha = 1.0
            }, completion: nil)
    }
    
    func fadeIn(completion: () -> Void){
        UIView.animateWithDuration(1.0, delay: 0.3, options: [], animations: {
            self.quote.alpha = 1.0
            self.tutorialContainer.alpha = 1.0
            self.fadeView.alpha = 0.75
            self.startButton.alpha = 1.0
            }, completion: { finished in
                completion()
        })
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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func startButtonAction(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let viewed = defaults.boolForKey("tutorialViewed")
        defaults.setBool(true, forKey: "tutorialViewed")
        
        if viewed{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
        
    }
    
}