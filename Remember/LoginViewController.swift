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
        
        if (loginView.emailTextField.text!.isEmpty || loginView.passwordTextField.text!.isEmpty){
            let alertController = UIAlertController(title: "Missing Email/Password", message:
                "Please add email/password", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            signUp(loginView.emailTextField.text!, password: loginView.passwordTextField.text!)
        }
    }
    
    
    func login(email: String, password: String){
        self.view.endEditing(true)
        let success = ParseServerProxy.parseProxy.login(email, pass: password)
        enterApp(success)
    }
    
    func signUp(email: String, password: String){
        self.view.endEditing(true)
        let success = ParseServerProxy.parseProxy.signUp(email, password: password)
        enterApp(success)
    }
    
    func enterApp(success: Bool){
        if success {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mainVC = storyboard.instantiateViewControllerWithIdentifier("collectionVC") as! MemoryCollectionViewController
            
            mainVC.modalTransitionStyle = .CrossDissolve
            mainVC.user = PFUser.currentUser()
            mainVC.memories = ParseServerProxy.parseProxy.getMemoriesOfUser()
            self.presentViewController(mainVC, animated: true, completion: nil)
        }
        else{
            displayFailedLogin()
        }
    }
    
    func displayFailedLogin(){
        let alertController = UIAlertController(title: "Incorrect Email/Password", message:
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

