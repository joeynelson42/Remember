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

class MemoryCollectionViewController: UIViewController {

    var user: PFObject!
    var memories = [LocalMemory]()
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var memoryCollectionView: MemoryCollectionView!
    var previousContentOffset: CGPoint!
    
    var filteredMemories = [LocalMemory]()
    
    @IBOutlet weak var addMemoryButton: UIButton!
    @IBOutlet weak var memoryCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        memoryCollectionView = (self.view as! MemoryCollectionView)
        memoryCollectionView.controller = self
        filteredMemories = memories
    }
    
    override func viewWillAppear(animated: Bool) {
        filteredMemories = memories
        
        if memories.isEmpty{
            animateAddButton()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        memoryCollectionView.hideFade()
        memoryCollectionView.sideMenuView.hideMenu()
    }
    
    @IBAction func addNewMemory(sender: UIButton) {
        let addVC = mainStoryboard.instantiateViewControllerWithIdentifier("AddMemoryVC")
        (addVC as! AddMemoryViewController).collectionVC = self
        self.presentViewController(addVC, animated: true, completion: nil)
    }
    
    func logout(){
        memoryCollectionView.dismissMenu()
        PFUser.logOut()
        user = nil
        
        let loginVC = mainStoryboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
        self.presentViewController(loginVC, animated: false, completion: nil)
    }
    
    func animateAddButton(){
        UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.Repeat, .AllowUserInteraction, .CurveEaseIn], animations: {
                self.addMemoryButton.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(CGFloat(M_PI)), CGAffineTransformMakeScale(1.15, 1.15))
            }, completion: nil)
    }
    
}


extension MemoryCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMemories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memoryCell", forIndexPath: indexPath) as! MemoryCollectionCell
        
        cell.memory = filteredMemories[indexPath.row]
        
        cell.title.text = filteredMemories[indexPath.row].title
        cell.image.image = filteredMemories[indexPath.row].mainImage
        cell.image.contentMode = .ScaleAspectFill
        cell.date.text = filteredMemories[indexPath.row].startDate.getFormattedDate(filteredMemories[indexPath.row].endDate)
        cell.memoryCollectionVC = self
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
        let memoryVC = mainStoryboard.instantiateViewControllerWithIdentifier("MemoryVC")
        if(filteredMemories[indexPath.row].images.count == 0){
            filteredMemories[indexPath.row].images = ParseServerProxy.parseProxy.getMemoryImagesForMemory(filteredMemories[indexPath.row])
        }
        
        (memoryVC as! MemoryViewController).memory = filteredMemories[indexPath.row]
        (memoryVC as! MemoryViewController).collectionVC = self
        self.presentViewController(memoryVC, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
        
        guard let _ = previousContentOffset else{
            //memoryCollectionView.hideSearchBar()
            previousContentOffset = CGPoint(x: 0, y: 0)
            return
        }
        
        if scrollView.contentOffset.y > previousContentOffset.y{
            memoryCollectionView.hideSearchBar()
        }
        else{
            memoryCollectionView.showSearchBar()
        }
    }
}


extension MemoryCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        
        return CGSize(width: screenWidth, height: 179)
        
    }
}

extension MemoryCollectionViewController: UISearchBarDelegate{
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMemories.removeAll()
        
        for memory in memories{
            let titleLC = memory.title.lowercaseString
            let searchLC = searchText.lowercaseString
            
            if titleLC.containsString(searchLC){
                filteredMemories.append(memory)
            }
        }
        
        if(searchText == ""){
            filteredMemories = memories
        }
        
        memoryCollection.reloadData()
    }
}




