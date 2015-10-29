//
//  AddMemoryViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AddMemoryViewController: UIViewController{
    
    var memory: Memory!
    
    override func viewDidLoad() {
        if let mem = memory{
            //edit mode: load the memory into the editable fields
        }
        else{
            //add new memory: show empty fields
        }
    }
    
    func addPhoto(){
        
    }
    
    func removeQuote(){
        
    }
    
    func addNewQuoteSkeleton(){
        //When a user finishes a quote, create a new quote skeleton automatically
    }
    
    func setBackgroundPhoto(){
        //called by selecting one of the already uploaded photos
    }
    
    func showCalendar(){
        //bring up calendar
    }
    
    func saveDate(startDate: NSDate, endDate: NSDate){
        //called from the calendar pop-up
    }
    
    func saveMemory(){
        //ParseServerProxy.parseProxy.createMemory(<#T##memoryID: String##String#>, title: <#T##String#>, images: <#T##[UIImage]#>, startDate: <#T##NSDate#>, endDate: <#T##NSDate#>, story: <#T##String#>, quotes: <#T##[String]#>, taggedIDs: <#T##[String]#>)
    }
    
    func cancel(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}