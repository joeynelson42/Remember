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
    
    //Server Proxy Singleton
    //get this using ParseServerProxy.parseProxy
    static let parseProxy = ParseServerProxy()
    
    let context: NSManagedObjectContext!
    let permissions = ["public_profile"]
    
    init(){
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    func login(email: String, pass: String) -> Bool{
        var success = true
        
        do{
            try PFUser.logInWithUsername(email, password: pass)
        }
        catch let err as NSError{
            print("failed login with error: \(err)")
            success = false
        }
        return success
    }
    
    func signUp(email: String, password: String) -> Bool{
        let parseUser = PFUser()
        parseUser.username = email
        parseUser.password = password
        
        var success = true
        
        do{
            try parseUser.signUp()
        }
        catch let err as NSError{
            print("failed signup with error: \(err)")
            success = false
        }
        
        return success
    }
    
    func createMemory(memoryID: String, title: String, images: [UIImage], mainImage: UIImage, startDate: NSDate, endDate: NSDate, story: String){
        
        
        // SAVING MEMORY IN PARSE-----------------------------
        
        let mainImageFile = imagesToParseObjects([mainImage])
        let newMemory = PFObject(className: "Memory")
        newMemory["memoryID"] = memoryID
        newMemory["title"] = title
        newMemory["mainImage"] = mainImageFile
        newMemory["story"] = story
        newMemory["startDate"] = NSDateToString(startDate)
        newMemory["endDate"] = NSDateToString(endDate)
        newMemory["username"] = PFUser.currentUser()?.username

        //newMemory["quotes"] = quotes
        //newMemory["taggedIDs"] = taggedIDs
        newMemory.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if success == true {
                print("Memory saved!")
            } else {
                print(error)
            }
        }
        
        
        //Save images separately into a MemoryImages Object
        let memoryImages = PFObject(className: "MemoryImages")
        let imageFiles = imagesToParseObjects(images)
        
        memoryImages["imageFiles"] = imageFiles
        memoryImages["memoryID"] = memoryID
    
        memoryImages.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if success == true {
                print("Memory saved!")
            } else {
                print(error)
            }
        }
        
        
        //----------------------------------------------------
    }
    
    func updateMemory(memoryID: String, title: String, images: [UIImage], mainImage: UIImage, startDate: NSDate, endDate: NSDate, story: String){
        
        var pfMemories = [PFObject]()
        
        //get PFObject
        let query = PFQuery(className: "Memory")
        query.whereKey("memoryID", equalTo: memoryID)
        
        do{
            try pfMemories = query.findObjects()
        }
        catch let err as NSError{
            print("Memory query failed with error: \(err)")
        }
        
        // UPDATING MEMORY IN PARSE-----------------------------
        let mainImageFile = imagesToParseObjects([mainImage])
        let updatedMemory = pfMemories.first!
        updatedMemory["memoryID"] = memoryID
        updatedMemory["title"] = title
        updatedMemory["mainImage"] = mainImageFile
        updatedMemory["story"] = story
        updatedMemory["startDate"] = NSDateToString(startDate)
        updatedMemory["endDate"] = NSDateToString(endDate)
        updatedMemory["username"] = PFUser.currentUser()?.username
        updatedMemory.saveEventually()
        
        //newMemory["quotes"] = quotes
        //newMemory["taggedIDs"] = taggedIDs
        
        updatedMemory.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if success == true {
                print("Memory saved!")
            } else {
                print(error)
            }
        }
        
        
        //Save images separately into a MemoryImages Object
        
        //get MemoryImages PFObject
        let imagesQuery = PFQuery(className: "MemoryImages")
        imagesQuery.whereKey("memoryID", equalTo: memoryID)
        
        do{
            try pfMemories = imagesQuery.findObjects()
        }
        catch let err as NSError{
            print("Memory query failed with error: \(err)")
        }
        
        let memoryImages = pfMemories.first!
        let imageFiles = imagesToParseObjects(images)
        
        memoryImages["imageFiles"] = imageFiles
        memoryImages["memoryID"] = memoryID
        
        memoryImages.saveEventually()
        
        //----------------------------------------------------
    }
    
    func imagesToParseObjects(images: [UIImage]) -> [PFFile]{
        var imageFiles = [PFFile]()
        
        for (i, image) in images.enumerate(){
            let imageData = UIImagePNGRepresentation(image)
            let imageFile = PFFile(name:"image\(i).png", data:imageData!)
            imageFiles.append(imageFile!)
        }
        
        return imageFiles
    }
    
    func NSDateToString(date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM:dd:yyyy"
        return dateFormatter.stringFromDate(date)
    }
    
    func getMemoriesOfUser() -> [LocalMemory]{
        var pfMemories = [PFObject]()
        var memories = [LocalMemory]()
        
        let query = PFQuery(className: "Memory")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        
        do{
            try pfMemories = query.findObjects()
        }
        catch let err as NSError{
            print("Memory query failed with error: \(err)")
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM:dd:yyyy"
        
        for pfMemory in pfMemories{
            let title = pfMemory["title"] as? String
            
            let date = (pfMemory["startDate"] as? String)!
            
            let startDate = dateFormatter.dateFromString((pfMemory["startDate"] as? String)!)
            let endDate = dateFormatter.dateFromString((pfMemory["endDate"] as? String)!)
            let mainImage = getPhotosFromParseArray(pfMemory["mainImage"] as! [PFFile]).first
            let story = pfMemory["story"] as? String
            let quotes = ""
            let ID = pfMemory["memoryID"] as? String
            
            let newMemory = LocalMemory(Mtitle: title!, MstartDate: startDate!, MendDate: endDate!, MmainImage: mainImage!, Mstory: story!, Mquotes: quotes, MID: ID!)
            memories.append(newMemory)
        }
        
        return memories
    }
    
    func getMemoryImagesForMemory(memory: LocalMemory) -> [UIImage]{
        var pfMemories = [PFObject]()
        var memoryImages = [UIImage]()
        
        let query = PFQuery(className: "MemoryImages")
        query.whereKey("memoryID", equalTo: memory.ID)
        
        do{
            try pfMemories = query.findObjects()
        }
        catch let err as NSError{
            print("MemoryImage query failed with error: \(err)")
        }
        
        let memoryImageObject = pfMemories.first!
        memoryImages = getPhotosFromParseArray(memoryImageObject["imageFiles"] as! [PFFile])
        
        return memoryImages
    }
    

    func getPhotosFromParseArray(files: [PFFile]) -> [UIImage]{
        var images = [UIImage]()
        for userImageFile in files{
            do{
                let imageData = try userImageFile.getData()
                let image = UIImage(data:imageData)
                images.append(image!)
            }
            catch let err as NSError{
                print("Failed to fetch photo with error: \(err)")
            }
        }
        return images
    }
    
    func deleteMemory(memory: LocalMemory){
        let query = PFQuery(className: "Memory")
        query.whereKey("memoryID", equalTo: memory.ID)
        var pfMemories = [PFObject]()
        
        do{
            try pfMemories = query.findObjects()
        }
        catch let err as NSError{
            print("Memory query failed with error: \(err)")
        }
        
        
        pfMemories.first?.deleteInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            if succeeded{
                print("Delete successful")
            }
            else{
                print("Delete failed with error: \(error)")
            }
        }
    }
}







