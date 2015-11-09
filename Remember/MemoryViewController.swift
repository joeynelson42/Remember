//
//  MemoryViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class MemoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var memory: LocalMemory!
    var images = [UIImage]()
    var infoVisible = informationVisible.story
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var collectionVC = MemoryCollectionViewController()
    
    @IBOutlet var memoryView: MemoryView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        loadMemory()
    }
    
    override func viewDidAppear(animated: Bool) {
        loadMemory()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! MemoryImageCollectionCell
        cell.imageView.image = images[indexPath.row]
        cell.imageView.contentMode = .ScaleAspectFill
        if(images[indexPath.row].size.height < images[indexPath.row].size.width){
            cell.orientation = .portrait
        }
        else{
            cell.orientation = .landscape
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //TODO: expand photo to full screen
        
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("carouselVC") as! ImageCarouselViewController
        
        vc.images = memory.images
        vc.initialIndex = indexPath.row
        
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func toggleInformation(){
        if infoVisible == .story{
            showQuotes()
        }
        else{
            showStory()
        }
    }
    
    func showStory(){
        //TODO: transition over to story, figure out a cool animation
    }
    
    func showQuotes(){
        //TODO: transition over to quotes, figure out a cool animation
    }
    
    func editMemory(){
        let editVC = AddMemoryViewController()
        editVC.memory = memory
        self.presentViewController(editVC, animated: true, completion: nil)
    }
    
    func loadMemory(){
        self.images = memory.images
        self.memoryView.titleLabel.text = memory.title
        self.memoryView.dateLabel.text = memory.startDate.getFormattedDate(memory.endDate)
        self.memoryView.storyView.text = memory.story
        self.memoryView.backgroundImageView.image = memory.mainImage
        self.memoryView.backgroundImageView.contentMode = .ScaleAspectFill
    }
    
    @IBAction func editButtonAction(sender: AnyObject) {
        let editVC = mainStoryboard.instantiateViewControllerWithIdentifier("AddMemoryVC")
        (editVC as! AddMemoryViewController).memory = memory
        (editVC as! AddMemoryViewController).memoryVC = self
        (editVC as! AddMemoryViewController).collectionVC = collectionVC
        editVC.modalTransitionStyle = .CrossDissolve
        self.presentViewController(editVC, animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

enum informationVisible{
    case story
    case quotes
}