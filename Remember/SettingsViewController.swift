//
//  SettingsViewController.swift
//  Remember
//
//  Created by Joey on 11/13/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit
import Parse

class SettingsViewController: UIViewController{
    
    let APP_ID = "1057376766"
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var progressIndicator: UIView!
    
    override func viewDidLoad() {
        deleteButton.layer.cornerRadius = 4.0
        reviewButton.layer.cornerRadius = 4.0
        
        progressIndicator.alpha = 0.0
        progressIndicator.layer.cornerRadius = 5.0
        progressIndicator.backgroundColor = UIColor.fromHex(0x434242, alpha: 0.7)
    }
    
    @IBAction func reviewButtonAction(sender: AnyObject) {
        jumpToAppStore()
    }
    
    func jumpToAppStore() {
        let url = "itms-apps://itunes.apple.com/app/id\(APP_ID)"
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteButtonAction(sender: AnyObject) {
        showDeleteConfirmation()
    }
    
    func showDeleteConfirmation(){
        let alertController = UIAlertController(title: "Are you SURE?", message:
            "", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes, get me outta here!", style: UIAlertActionStyle.Destructive, handler: { (alertController) -> Void in self.deleteAccount() }))
        alertController.addAction(UIAlertAction(title: "No, I'll never leave you!", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func deleteAccount(){
        UIView.animateWithDuration(0.3, animations: {
            self.progressIndicator.alpha = 1.0
            }, completion: {finished in
                ParseServerProxy.parseProxy.deleteUser()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
                self.presentViewController(vc, animated: false, completion: nil)
        })
    }
}