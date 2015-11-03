//
//  AddMemoryViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AddMemoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var memory: Memory!
    var images: [UIImage]!
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet var addMemoryView: AddMemoryView!
    
    override func viewDidLoad() {
        
        imagePicker.delegate = self
        loadDummyImages()
        addMemoryView.addTitleField.attributedPlaceholder = NSAttributedString(string:"Add Title...", attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        
        
        if let mem = memory{
            //edit mode: load the memory into the editable fields
        }
        else{
            //add new memory: show empty fields
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if addMemoryView.calendarVisible{
            addMemoryView.toggleCalendar()
        }
    }
    
    func loadDummyImages(){
        images = [UIImage(named: "wedding")!, UIImage(named: "cabin")!, UIImage(named: "fearmonth")!, UIImage(named: "sammyAtAirport")!, UIImage(named: "stitches")!]
    }
    
    
    //MARK: Image Collection View
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! MemoryImageCollectionCell
        
        if indexPath.row == images.count{
            cell.imageView.image = UIImage(named: "AddPhotoIcon")
            
            cell.orientation = .portrait
        }
        else{
            cell.imageView.image = images[indexPath.row]
            
            if images[indexPath.row].size.height > images[indexPath.row].size.width{
                cell.orientation = .portrait
            }
            else{
                cell.orientation = .landscape
            }
        }
        cell.imageView.contentMode = .ScaleAspectFill
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.row == images.count {
            return UIImage(named: "AddPhotoIcon")!.size
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
        
        if(indexPath.row == images.count){
            addPhoto()
        }
        else{
            print("set as main image")
        }
    }
    
    //MARK: Add photo stuff
    func addPhoto(){
        imagePicker.allowsEditing = false //2
        imagePicker.sourceType = .PhotoLibrary //3
        presentViewController(imagePicker, animated: true, completion: nil)//4
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        
        var transformScale: CGFloat = 0.0
        if chosenImage.size.height > chosenImage.size.width{
            transformScale = 230/chosenImage.size.height
        }
        else{
            transformScale = 130/chosenImage.size.height
        }
        
        let size = CGSizeApplyAffineTransform(chosenImage.size, CGAffineTransformMakeScale(transformScale, transformScale))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        chosenImage.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        images.append(scaledImage)
        
        imageCollectionView.reloadData()
        imageCollectionView.collectionViewLayout.invalidateLayout()
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Text field stuff
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
    
    func textViewDidBeginEditing(textView: UITextView) {
        if(textView.text == "Write the story..."){
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text == ""){
            textView.text = "Write the story..."
        }
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