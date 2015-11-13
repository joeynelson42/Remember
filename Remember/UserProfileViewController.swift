//
//  UserProfileViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit
import Parse

class UserProfileViewController: UIViewController{
    var user: PFUser!
    var memoryCount = Int()
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    @IBOutlet weak var memoryCountLabel: UILabel!
    
    override func viewDidLoad() {
        user = PFUser.currentUser()
        
        usernameLabel.text = user.username
        
        let date = user.createdAt
        memberSinceLabel.text = "Member since \(date!.fullDate())"
        
        memoryCountLabel.text = "Memories: \(memoryCount)"
    }
    
    
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}