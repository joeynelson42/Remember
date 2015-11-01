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

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var loginView: LoginView!
    
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        login(loginView.emailTextField.text!, password: loginView.passwordTextField.text!)
    }
    
    @IBAction func signUpButtonAction(sender: AnyObject) {
        signUp()
    }
    
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mainVC = storyboard.instantiateViewControllerWithIdentifier("collectionVC") as! MemoryCollectionViewController
            mainVC.user = PFUser.currentUser()
//            mainVC.memories = ParseServerProxy.parseProxy.getMemoriesOfUser("userID goes here")
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
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardShown:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        
        keyboardHeight = keyboardFrame.height
        
        self.loginView.moveContainer(true, keyboardHeight: keyboardHeight)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.loginView.moveContainer(false, keyboardHeight: keyboardHeight)
    }
    
    
}

