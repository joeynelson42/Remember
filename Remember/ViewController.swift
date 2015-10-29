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

class ViewController: UIViewController {
    
    var parseProxy: ParseServerProxy!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseProxy = ParseServerProxy()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

