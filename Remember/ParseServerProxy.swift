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
import CoreData

class ParseServerProxy{
    
    //get this using ParseServerProxy.parseProxy
    static let parseProxy = ParseServerProxy()
    
    let context: NSManagedObjectContext!
    
    init(){
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
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
    
    func createMemory(memoryID: String, title: String, images: [UIImage], startDate: NSDate, endDate: NSDate, story: String, quotes: [String], taggedIDs: [String]){
        
        
        // SAVING MEMORY IN PARSE-----------------------------
        let imageFiles = imagesToParseObjects(images)
        let newMemory = PFObject(className: "Memory")
        newMemory["memoryID"] = memoryID
        newMemory["title"] = title
        newMemory["images"] = imageFiles
        newMemory["story"] = story
        newMemory["startDate"] = NSDateToString(startDate)
        newMemory["endDate"] = NSDateToString(endDate)
        newMemory["quotes"] = quotes
        newMemory["taggedIDs"] = taggedIDs
        newMemory.saveInBackground()
        //----------------------------------------------------
        
        
        
        
        //TODO: SAVING MEMORY ON DEVICE----------------------------
        
        
        //----------------------------------------------------
        
        
        
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
    
    func imagesToParseObjects(images: [UIImage]) -> [PFFile]{
        //TODO:
        let imageFiles = [PFFile]()
        return imageFiles
    }
    
    func NSDateToString(date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm:dd:yyy"
        return dateFormatter.stringFromDate(date)
    }
    
    func getMemoriesOfUser(userID: String) -> [Memory]{
        let memories = [Memory]()
        return memories
    }
    
    
    func getFriendsOfUser(userID: String) -> [PFUser]{
        let friends = [PFUser]()
        return friends
    }
    
}