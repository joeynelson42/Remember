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
    @IBOutlet weak var progressContainer: UIView!
    
    
    override func viewDidLoad() {
        memoryCollectionView = (self.view as! MemoryCollectionView)
        memoryCollectionView.controller = self
        filteredMemories = memories
        
        progressContainer.alpha = 0.0
        progressContainer.layer.cornerRadius = 5.0
        progressContainer.backgroundColor = UIColor.fromHex(0x434242, alpha: 0.7)
    }
    
    override func viewWillAppear(animated: Bool) {
        filteredMemories = memories
        
        if memories.isEmpty{
            animateAddButton()
        }
        
        progressContainer.alpha = 0.0
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
        UIView.animateWithDuration(0.3, animations: {
            self.progressContainer.alpha = 1.0
            }, completion: {finished in
                self.memoryCollectionView.dismissMenu()
                PFUser.logOut()
                self.user = nil
                
                let loginVC = self.mainStoryboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
                self.presentViewController(loginVC, animated: false, completion: nil)
        })
    }
    
    func animateAddButton(){
        UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.Repeat, .AllowUserInteraction, .CurveEaseIn], animations: {
                self.addMemoryButton.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(CGFloat(M_PI)), CGAffineTransformMakeScale(1.15, 1.15))
            }, completion: nil)
    }
    
    @IBAction func RButtonAction(sender: AnyObject) {
        showTutorial()
    }
    
    func showTutorial(){
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("tutorialVC") as! IntroViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func showSettings(){
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("settingsVC") as! SettingsViewController
        self.presentViewController(vc, animated: true, completion: nil)
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
        
        UIView.animateWithDuration(0.3, animations: {
            self.progressContainer.alpha = 1.0
            }, completion: {finished in
                let memoryVC = self.mainStoryboard.instantiateViewControllerWithIdentifier("MemoryVC")
                if(self.filteredMemories[indexPath.row].images.count == 0){
                    self.filteredMemories[indexPath.row].images = ParseServerProxy.parseProxy.getMemoryImagesForMemory(self.filteredMemories[indexPath.row])
                }
                
                (memoryVC as! MemoryViewController).memory = self.filteredMemories[indexPath.row]
                (memoryVC as! MemoryViewController).collectionVC = self
                self.presentViewController(memoryVC, animated: true, completion: nil)
        })
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
        
        
        //parallax effect on images
        if let visibleCells = memoryCollection.visibleCells() as? [MemoryCollectionCell] {
            for cell in visibleCells{
                let yOffset = ((memoryCollection!.contentOffset.y - cell.frame.origin.y) / cell.image.frame.height) * cell.OFFSET_SPEED
                cell.offset(CGPointMake(0.0, yOffset))
            }
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




