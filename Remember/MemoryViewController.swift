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
    
    var memory: Memory!
    var images = [UIImage]()
    var infoVisible = informationVisible.story
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        images = [UIImage(named: "stitches")!, UIImage(named: "sammyAtAirport")!, UIImage(named: "fearmonth")!, UIImage(named: "wedding")!, UIImage(named: "cabin")!]
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
    
    
}

enum informationVisible{
    case story
    case quotes
}