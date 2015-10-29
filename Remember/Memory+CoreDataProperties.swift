//
//  Memory+CoreDataProperties.swift
//  
//
//  Created by Joey on 10/28/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Memory {

    @NSManaged var title: String?
    @NSManaged var startDate: NSDate?
    @NSManaged var endDate: NSDate?
    @NSManaged var imageURLs: String?
    @NSManaged var story: String?
    @NSManaged var quotes: String?
    @NSManaged var taggedIDs: String?

}
