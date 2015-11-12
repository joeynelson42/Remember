//
//  MemoryIntroViewController.swift
//  Remember
//
//  Created by Joey on 11/11/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class MemoryIntroViewController: UIViewController{
    
    @IBOutlet weak var tutorialContainer: UIView!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var fadeView: UIView!
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var imageCollection: UIView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var imageCollectionBackground: UIView!
    
    var animationBegun = false
    var animationTimer = NSTimer()
    
    override func viewDidLoad() {
        imageCollection.layer.zPosition = CGFloat(MAXFLOAT)
        imageCollectionBackground.layer.zPosition = CGFloat(MAXFLOAT - 1)
        
        self.tutorialContainer.layer.cornerRadius = 5.0
        self.fadeView.backgroundColor = UIColor.fromHex(0x434242, alpha: 0.7)

        
        self.tutorialContainer.alpha = 0.0
        self.quote.alpha = 0.0
        self.fadeView.alpha = 0.0
    }
    
    override func viewWillAppear(animated: Bool) {
        self.imageCollection.transform = CGAffineTransformMakeTranslation(90, 0)
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
        
    }
    
    func fadeIn(){
        UIView.animateWithDuration(1.0, delay: 0.3, options: [], animations: {
            self.quote.alpha = 1.0
            self.tutorialContainer.alpha = 1.0
            self.fadeView.alpha = 1.0
            }, completion: nil)
    }
    
    func fadeIn(completion: () -> Void){
        UIView.animateWithDuration(1.0, delay: 0.3, options: [], animations: {
            self.quote.alpha = 1.0
            self.tutorialContainer.alpha = 1.0
            self.fadeView.alpha = 1.0
            }, completion: { finished in
                completion()
        })
    }
    
    func animate(){
        UIView.animateWithDuration(2, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
            self.imageCollection.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: { finished in
                UIView.animateWithDuration(0.2, delay: 0.3, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
                    self.image2.transform = CGAffineTransformMakeScale(0.9, 0.9)
                    }, completion: {finished in
                        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
                            self.image2.transform = CGAffineTransformMakeScale(1.0, 1.0)
                            }, completion: {finished in
                                UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
                                    self.imageCollectionBackground.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(2, 3.5), CGAffineTransformMakeTranslation(0, 50))
                                    self.imageCollection.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.5, 1.5), CGAffineTransformMakeTranslation(0, 20))
                                    }, completion: {finished in
                                        UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
                                            self.imageCollection.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                            self.imageCollectionBackground.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeTranslation(0, 0))
                                            }, completion: {finished in
                                                UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
                                                    self.imageCollection.transform = CGAffineTransformMakeTranslation(90, 0)
                                                    }, completion: {finished in
                                                        self.startTimer()
                                                })
                                        })
                                })
                        })
                })
        })
    }
    
    func startTimer(){
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "animate", userInfo: nil, repeats: false)
    }

}