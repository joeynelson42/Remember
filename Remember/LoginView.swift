//
//  LoginView.swift
//  Remember
//
//  Created by Joey on 10/30/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView{
    
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func layoutSubviews() {
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email",
            attributes:[NSForegroundColorAttributeName: UIColor.fromHex(0xFFFFFF, alpha: 0.5)])
        
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.fromHex(0xFFFFFF, alpha: 0.5)])
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        self.addGestureRecognizer(tap)
    }
    
    func DismissKeyboard(){
        self.endEditing(true)
    }
    
    func moveContainer(moveUp: Bool, keyboardHeight: CGFloat){
        if moveUp{
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: {(
                self.loginContainerView.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight)
                )}, completion: nil)
        }
        else{
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: {(
                self.loginContainerView.transform = CGAffineTransformMakeTranslation(0, 0)
                )}, completion: nil)
        }
    }
}