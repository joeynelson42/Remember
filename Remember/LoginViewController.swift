//
//  LoginViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit
import Parse

class LoginViewController: UIViewController{
    
    func login(username: String, password: String){
        let success = ParseServerProxy.parseProxy.login()
        enterApp(success)
    }
    
    func signUp(){
        let success = ParseServerProxy.parseProxy.signUp()
        enterApp(success)
    }
    
    func enterApp(success: Bool){
        if success{
            let mainVC = MemoryCollectionViewController()
            mainVC.user = PFUser.currentUser()
            mainVC.memories = ParseServerProxy.parseProxy.getUsersMemories("userID goes here")
            self.presentViewController(mainVC, animated: true, completion: nil)
        }
        else{
            displayFailedLogin()
        }
    }
    
    func displayFailedLogin(){
        let alertController = UIAlertController(title: "Incorrect Username/Password", message:
            "Please try again", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

