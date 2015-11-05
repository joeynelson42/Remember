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
    var memories = [LocalMemory]()
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var memoryCollectionView: MemoryCollectionView!
    
    override func viewDidLoad() {
        memoryCollectionView = (self.view as! MemoryCollectionView)
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
        cell.image.image = memories[indexPath.row].mainImage
        cell.image.contentMode = .ScaleAspectFill
        cell.date.text = memories[indexPath.row].startDate.getFormattedDate(memories[indexPath.row].endDate)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memoryVC = mainStoryboard.instantiateViewControllerWithIdentifier("MemoryVC")
        (memoryVC as! MemoryViewController).memory = memories[indexPath.row]
        (memoryVC as! MemoryViewController).collectionVC = self
        self.presentViewController(memoryVC, animated: true, completion: nil)
    }

    @IBAction func addNewMemory(sender: UIButton) {
        let addVC = mainStoryboard.instantiateViewControllerWithIdentifier("AddMemoryVC")
        (addVC as! AddMemoryViewController).collectionVC = self
        self.presentViewController(addVC, animated: true, completion: nil)
    }
}









