//
//  AddMemoryViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AddMemoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate{
    
    var memory: Memory!
    var images: [UIImage]!
    
    @IBOutlet var addMemoryView: AddMemoryView!
    
    override func viewDidLoad() {
        loadDummyImages()
        addMemoryView.addTitleField.attributedPlaceholder = NSAttributedString(string:"Add Title...", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        if let mem = memory{
            //edit mode: load the memory into the editable fields
        }
        else{
            //add new memory: show empty fields
        }
    }
    
    
    
    func loadDummyImages(){
        images = [UIImage(named: "wedding")!, UIImage(named: "cabin")!, UIImage(named: "fearmonth")!, UIImage(named: "sammyAtAirport")!, UIImage(named: "stitches")!, UIImage(named: "AddPhotoIcon")!]
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
        
        if images[indexPath.row].size.height > images[indexPath.row].size.width{
            cell.orientation = .portrait
        }
        else{
            cell.orientation = .landscape
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.row == images.count - 1 {
            return images[indexPath.row].size
        }
        else if images[indexPath.row].size.height > images[indexPath.row].size.width{
            return CGSize(width: 130, height: 230)
        }
        else{
            return CGSize(width: 230, height: 130)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        
        if(indexPath.row == images.count - 1){
            print("last cell")
        }
        else{
            print("set as main image")
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if(textField.placeholder == "Add Title..."){
            textField.attributedPlaceholder = NSAttributedString(string:" ",
                attributes:[NSForegroundColorAttributeName: UIColor.clearColor()])
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(textField.placeholder == " "){
            textField.attributedPlaceholder = NSAttributedString(string:"Add Title...",
                attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
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
    
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}