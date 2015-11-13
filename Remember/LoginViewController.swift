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
    @IBOutlet weak var progressContainer: UIView!
    
    var keyboardHeight: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        
        progressContainer.alpha = 0.0
        progressContainer.layer.cornerRadius = 5.0
        progressContainer.backgroundColor = UIColor.fromHex(0x434242, alpha: 0.7)
    }
    
    override func viewWillAppear(animated: Bool) {
        progressContainer.alpha = 0.0
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        self.view.endEditing(true)
        UIView.animateWithDuration(0.3, animations: {
                self.progressContainer.alpha = 1.0
            }, completion: {finished in
                self.login(self.loginView.emailTextField.text!, password: self.loginView.passwordTextField.text!)
        })
    }
    
    @IBAction func signUpButtonAction(sender: AnyObject) {
        self.view.endEditing(true)
        if (loginView.emailTextField.text!.isEmpty || loginView.passwordTextField.text!.isEmpty){
            let alertController = UIAlertController(title: "Missing Username/Password", message:
                "Please add username/password", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else{
            UIView.animateWithDuration(0.3, animations: {
                self.progressContainer.alpha = 1.0
                }, completion: {finished in
                    self.signUp(self.loginView.emailTextField.text!, password: self.loginView.passwordTextField.text!)
            })
        }
    }
    
    
    func login(email: String, password: String){
        let success = ParseServerProxy.parseProxy.login(email, pass: password)
        enterApp(success, failureBlock: {self.displayFailedLogin()})
    }
    
    func signUp(email: String, password: String){
        let success = ParseServerProxy.parseProxy.signUp(email, password: password)
        enterApp(success, failureBlock: {self.displayFailedSignUp()})
    }
    
    func enterApp(success: Bool, failureBlock: () -> Void){
        if success {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mainVC = storyboard.instantiateViewControllerWithIdentifier("collectionVC") as! MemoryCollectionViewController
            
            mainVC.modalTransitionStyle = .CrossDissolve
            mainVC.user = PFUser.currentUser()
            mainVC.memories = ParseServerProxy.parseProxy.getMemoriesOfUser()
            self.presentViewController(mainVC, animated: true, completion: nil)
        }
        else{
            UIView.animateWithDuration(0.3, animations: {
                self.progressContainer.alpha = 0.0
                }, completion: {finished in
                   failureBlock()
            })
            
        }
    }
    
    func displayFailedLogin(){
        let alertController = UIAlertController(title: "We couldn't find your Username/Password!", message:
            "Please try again,\n If you've forgotten please send an email to nelsonje.dev@gmail.com and we'll get you sorted out!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func displayFailedSignUp(){
        let alertController = UIAlertController(title: "Username is already in use!", message:
            "Great minds think alike, apparently", preferredStyle: UIAlertControllerStyle.Alert)
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

