//
//  CollectionIntroViewController.swift
//  Remember
//
//  Created by Joey on 11/11/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class CollectionIntroViewController: UIViewController{
    
    @IBOutlet weak var tutorialContainer: UIView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var quote: UIImageView!
    @IBOutlet weak var quoteContainer: UIView!
    
    var animationTimer = NSTimer()
    var animationBegun = false
    
    
    override func viewDidLoad() {
        navBar.layer.zPosition = CGFloat(MAXFLOAT)
        self.tutorialContainer.alpha = 0.0
        self.quote.alpha = 0.0
        self.quoteContainer.alpha = 0.0
        self.quoteContainer.backgroundColor = UIColor.clearColor()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = quoteContainer.bounds
        quoteContainer.addSubview(visualEffectView)
        
        
        self.tutorialContainer.layer.cornerRadius = 5.0
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
        self.quoteContainer.alpha = 0.0

    }
    
    func fadeIn(){
        UIView.animateWithDuration(1.0, delay: 0.3, options: [], animations: {
            self.quote.alpha = 1.0
            self.tutorialContainer.alpha = 1.0
            self.quoteContainer.alpha = 0.75
            }, completion: nil)
        }
    
    func fadeIn(completion: () -> Void){
        UIView.animateWithDuration(1.0, delay: 0.3, options: [], animations: {
            self.quote.alpha = 1.0
            self.tutorialContainer.alpha = 1.0
            self.quoteContainer.alpha = 0.75
            }, completion: { finished in
                completion()
        })
    }
    
    func animate(){
        UIView.animateWithDuration(2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
                self.collectionView.transform = CGAffineTransformMakeTranslation(0, -100)
            }, completion: { finished in
                UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.CurveEaseIn], animations: {
                    self.collectionView.transform = CGAffineTransformMakeTranslation(0, 0)
                    }, completion: {finished in
                        self.startTimer()
                })
        })
    }
    
    func startTimer(){
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "animate", userInfo: nil, repeats: false)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}