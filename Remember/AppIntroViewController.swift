//
//  AppIntroViewController.swift
//  Remember
//
//  Created by Joey on 11/11/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AppIntroViewController: UIViewController{
    
    @IBOutlet weak var introQuote: UIImageView!
    @IBOutlet weak var fadeView: UIView!
    
    override func viewDidLoad() {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark)) as UIVisualEffectView
        visualEffectView.frame = fadeView.bounds
        fadeView.addSubview(visualEffectView)
    }
    
    override func viewWillAppear(animated: Bool) {
        introQuote.alpha = 0.0
        fadeView.alpha = 0.0
        fadeView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        animateQuote()
    }
    
    func animateQuote(){
        UIView.animateWithDuration(1.0, animations: {
            self.introQuote.alpha = 1.0
            self.fadeView.alpha = 1.0
        })
    }
}