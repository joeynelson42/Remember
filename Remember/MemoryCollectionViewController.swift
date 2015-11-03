//
//  MemoryCollectionViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit
import Parse
import CoreData

class MemoryCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var user: PFObject!
    var memories: [Memory]!
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var memoryCollectionView: MemoryCollectionView!
    
    override func viewDidLoad() {
        loadDummyData()
        memoryCollectionView = (self.view as! MemoryCollectionView)
        memoryCollectionView.loadTiles()
        memoryCollectionView.sideMenuView.hideMenu()
        memoryCollectionView.sideMenuView.hidden = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissMenu")
        memoryCollectionView.menuFade.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(animated: Bool) {
        memoryCollectionView.hideFade()
        memoryCollectionView.sideMenuView.hideMenu()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memoryCell", forIndexPath: indexPath) as! MemoryCollectionCell

        cell.title.text = memories[indexPath.row].title
        cell.image.image = UIImage(named: memories[indexPath.row].imageURLs!)
        cell.date.text = "October \(indexPath.row), 2015"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MemoryCollectionCell
//        
//        let memoryVC = MemoryViewController()
//        memoryVC.memory = cell.memory
//        self.presentViewController(memoryVC, animated: false, completion: nil)
    }

    @IBAction func addNewMemory(sender: UIButton) {
        let addVC = mainStoryboard.instantiateViewControllerWithIdentifier("AddMemoryVC")
        self.presentViewController(addVC, animated: true, completion: nil)
    }
    
    func dismissMenu(){
        memoryCollectionView.hideFade()
        memoryCollectionView.sideMenuView.toggleMenu()
    }
    
    
    func loadDummyData(){
        let memory1 = NSEntityDescription.insertNewObjectForEntityForName("Memory", inManagedObjectContext: context) as! Memory
        memory1.title = "Jorie's Cabin"
        memory1.imageURLs = "cabin"
        
        let memory2 = NSEntityDescription.insertNewObjectForEntityForName("Memory", inManagedObjectContext: context) as! Memory
        memory2.title = "Bryan's Wedding"
        memory2.imageURLs = "wedding"
        
        let memory3 = NSEntityDescription.insertNewObjectForEntityForName("Memory", inManagedObjectContext: context) as! Memory
        memory3.title = "Sammy's Homecoming"
        memory3.imageURLs = "sammyAtAirport"
        
        let memory4 = NSEntityDescription.insertNewObjectForEntityForName("Memory", inManagedObjectContext: context) as! Memory
        memory4.title = "#FEARMONTH"
        memory4.imageURLs = "fearmonth"
        
        let memory5 = NSEntityDescription.insertNewObjectForEntityForName("Memory", inManagedObjectContext: context) as! Memory
        memory5.title = "Stitches"
        memory5.imageURLs = "stitches"
        
        memories = [memory1, memory2, memory3, memory4, memory5]
    }
}









