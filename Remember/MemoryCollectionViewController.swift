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

enum listType{
    case fullCells
    case reducedCells
}

class MemoryCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var user: PFObject!
    var memories: [Memory]!
    var listView = listType.fullCells
    
    
    override func viewDidLoad() {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = MemoryCollectionCell()
        cell.memory = memories[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MemoryCollectionCell
        
        let memoryVC = MemoryViewController()
        memoryVC.memory = cell.memory
        self.presentViewController(memoryVC, animated: false, completion: nil)
    }
    
    func openSideMenu(){
        //TODO: import SideMenuTiles but convert it to non-storyboard
    }
    
    func changeCollectionViewType(){
        if(listView == .fullCells){
            listView = .reducedCells
        }
        else{
            listView = .fullCells
        }
    }
    
    func addNewMemory(){
        let addNewVC = AddMemoryViewController()
        self.presentViewController(addNewVC, animated: false, completion: nil)
    }
    
    
    
    
    
    
}