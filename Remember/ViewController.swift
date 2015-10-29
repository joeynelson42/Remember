//
//  ViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI
import ParseFacebookUtilsV4

class ViewController: UIViewController, PFLogInViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let logInViewController = PFLogInViewController()
        logInViewController.delegate = self
        logInViewController.fields = [.UsernameAndPassword, .Facebook, .DismissButton]
        presentViewController(logInViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

