//
//  ParseServerProxy.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import Parse
import ParseFacebookUtilsV4

class ParseServerProxy{
    
    //get this using ParseServerProxy.parseProxy
    static let parseProxy = ParseServerProxy()
    
    func login() -> Bool{
        return true
    }
    
    func signUp() -> Bool{
        var success = false
        PFFacebookUtils.logInInBackgroundWithReadPermissions(nil) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                    success = true
                } else {
                    print("User logged in through Facebook!")
                    success = true
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
        return success
    }
    
    func createMemory(memoryID: String, title: String, imageURLs: [UIImage], startDate: NSDate, endDate: NSDate, story: String, quotes: [String], taggedIDs: String){
        
        
        
        
        
        
        
        
        //this is how you save an image! then just slap the url into a Memory Object
//        let selectedImage = UIImage()
//        let imageData = UIImagePNGRepresentation(selectedImage)
//        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
//        let imageURL = documentsURL.URLByAppendingPathComponent("\(memoryID)-1.png")
//        
//        if !imageData!.writeToURL(imageURL, atomically: false)
//        {
//            print("not saved")
//        } else {
//            print("saved")
//            NSUserDefaults.standardUserDefaults().setObject(imageURL, forKey: "imagePath")
//        }
    }
    
    func getUsersMemories(userID: String) -> [Memory]{
        var memories = [Memory]()
        return memories
        
        
    }
    
    
}