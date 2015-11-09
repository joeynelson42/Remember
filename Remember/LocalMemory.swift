//
//  LocalMemory.swift
//  Remember
//
//  Created by Joey on 11/4/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class LocalMemory{
    var title = String()
    var startDate = NSDate()
    var endDate = NSDate()
    var images = [UIImage]()
    var mainImage = UIImage()
    var story = String()
    var quotes = String()
    var ID = String()
    
    //init with images
    init(Mtitle: String, MstartDate: NSDate, MendDate: NSDate, Mimages: [UIImage], MmainImage: UIImage, Mstory: String, Mquotes: String, MID: String){
        title = Mtitle
        startDate = MstartDate
        endDate = MendDate
        images = Mimages
        mainImage = MmainImage
        story = Mstory
        quotes = Mquotes
        ID = MID
    }
    
    
    //init with no images
    init(Mtitle: String, MstartDate: NSDate, MendDate: NSDate, MmainImage: UIImage, Mstory: String, Mquotes: String, MID: String){
        title = Mtitle
        startDate = MstartDate
        endDate = MendDate
        mainImage = MmainImage
        story = Mstory
        quotes = Mquotes
        ID = MID
    }
}