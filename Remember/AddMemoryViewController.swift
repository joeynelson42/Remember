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
    
    var memory: LocalMemory!
    var images = [UIImage]()
    let imagePicker = UIImagePickerController()
    let PORTRAIT_IMAGE_SIZE = CGSize(width: 130, height: 230)
    let LANDSCAPE_IMAGE_SIZE = CGSize(width: 230, height: 130)
    var keyboardHeight: CGFloat!
    var currentBGIndexPath: NSIndexPath!
    var collectionVC = MemoryCollectionViewController()
    var memoryVC = MemoryViewController()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet var addMemoryView: AddMemoryView!
    
    var editMode = false
    
    override func viewDidLoad() {
        imagePicker.delegate = self
        registerForKeyboardNotifications()
        
                
        if let mem = memory{
            editMode = true
            images = memory.images
            addMemoryView.loadMemoryToBeEdited(mem)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if addMemoryView.calendarVisible{
            addMemoryView.calculateAnimationDistance()
            addMemoryView.toggleCalendar()
        }
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
            cell.imageView.image = UIImage(named: "AddPhotoNoBorder")
            cell.orientation = .portrait
            cell.alpha = 0.71
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
        
        cell.layer.borderColor = CGColor.fromHex(0xF8FAA0)
        cell.layer.borderWidth = 0.0
        
        cell.imageView.contentMode = .ScaleAspectFill
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
        if indexPath.row == images.count {
            return CGSize(width: 133, height: 206)
        }
        else if images[indexPath.row].size.height > images[indexPath.row].size.width{
            return PORTRAIT_IMAGE_SIZE
        }
        else{
            return LANDSCAPE_IMAGE_SIZE
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if images.count == 0{
            return PORTRAIT_IMAGE_SIZE
        }
        else{
            return CGSize(width: 5, height: 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        
        if(indexPath.row == images.count){
            addPhoto()
        }
        else{
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MemoryImageCollectionCell
            addMemoryView.backgroundImageView.image = cell.imageView.image
            
            toggleBackgroundPhotoSelect(indexPath)
        }
    }
    
    func toggleBackgroundPhotoSelect(indexPath: NSIndexPath){
        guard let previousBGIndexPath = currentBGIndexPath else{
            let cell = imageCollectionView.cellForItemAtIndexPath(indexPath)
            currentBGIndexPath = indexPath
            cell?.layer.borderWidth = 3.0
            return
        }
        currentBGIndexPath = indexPath
        
        let prevCell = imageCollectionView.cellForItemAtIndexPath(previousBGIndexPath)
        let currCell = imageCollectionView.cellForItemAtIndexPath(currentBGIndexPath)
        
        prevCell?.layer.borderWidth = 0.0
        currCell?.layer.borderWidth = 3.0
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
            transformScale = PORTRAIT_IMAGE_SIZE.height/chosenImage.size.height
        }
        else{
            transformScale = PORTRAIT_IMAGE_SIZE.width/chosenImage.size.height
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
        
        
        self.addMemoryView.moveContainer(false, keyboardHeight: keyboardHeight)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if(textView.text == "Write the story..."){
            textView.text = ""
        }
        self.keyboardHeight = addMemoryView.keyboardHeight
        self.addMemoryView.moveContainer(true, keyboardHeight: keyboardHeight)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text == ""){
            textView.text = "Write the story..."
        }
        self.addMemoryView.moveContainer(false, keyboardHeight: keyboardHeight)
    }
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardShown:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        
        keyboardHeight = keyboardFrame.height
        addMemoryView.keyboardHeight = keyboardHeight
    }
    
    func removeQuote(){
        
    }
    
    func addNewQuoteSkeleton(){
        //When a user finishes a quote, create a new quote skeleton automatically
    }
    
    //MARK: Saving the Memory
    
    @IBAction func checkMarkButtonAction(sender: AnyObject) {
        if editMode{
            updateMemory()
        }
        else{
            saveMemory()
        }
    }
    
    func saveMemory(){
        let memoryID = String.randomStringWithLength(13) as String
        
        if memoryReady() {
            
            ParseServerProxy.parseProxy.createMemory(memoryID, title: addMemoryView.addTitleField.text!, images: images, mainImage: addMemoryView.backgroundImageView.image!, startDate: addMemoryView.startPicker.date, endDate: addMemoryView.endPicker.date, story: addMemoryView.story.text)
            
            let newMemory = LocalMemory(Mtitle: addMemoryView.addTitleField.text!, MstartDate: addMemoryView.startPicker.date, MendDate: addMemoryView.endPicker.date, Mimages: images, MmainImage: addMemoryView.backgroundImageView.image!, Mstory: addMemoryView.story.text, Mquotes: "", MID: memoryID)
            
            collectionVC.memories.append(newMemory)
            collectionVC.memoryCollectionView.memoryCollection.reloadData()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            notifyNotReady()
        }
    }
    
    func updateMemory(){
        if memoryReady() {
            
            ParseServerProxy.parseProxy.updateMemory(memory.ID, title: addMemoryView.addTitleField.text!, images: images, mainImage: addMemoryView.backgroundImageView.image!, startDate: addMemoryView.startPicker.date, endDate: addMemoryView.endPicker.date, story: addMemoryView.story.text)
            
            let newMemory = LocalMemory(Mtitle: addMemoryView.addTitleField.text!, MstartDate: addMemoryView.startPicker.date, MendDate: addMemoryView.endPicker.date, Mimages: images, MmainImage: addMemoryView.backgroundImageView.image!, Mstory: addMemoryView.story.text, Mquotes: "", MID: memory.ID)
            
            
            for (i, mem) in collectionVC.memories.enumerate(){
                if memory.ID == mem.ID{
                    collectionVC.memories[i] = newMemory
                }
            }
            
            memoryVC.memory = newMemory
            collectionVC.memoryCollectionView.memoryCollection.reloadData()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            notifyNotReady()
        }
    }
    
    func memoryReady() -> Bool{
        if(addMemoryView.addTitleField.text! == "Add Title..."){ return false }
        else if(addMemoryView.dateButton.titleLabel?.text == "Add Date..."){ return false }
        else if(addMemoryView.story.text == "Write the story..."){ return false }
        else if(addMemoryView.backgroundImageView.image == nil){ return false }
        else{ return true }
    }
    
    func notifyNotReady(){
        var alert = ""
        if(addMemoryView.addTitleField.text! == "Add Title..."){ alert = "Missing a title" }
        else if(addMemoryView.dateButton.titleLabel?.text == "Add Date..."){ alert = "Missing a date" }
        else if(addMemoryView.story.text == "Write the story..."){ alert = "Missing a story" }
        else if(addMemoryView.backgroundImageView.image == nil){ alert = "Missing a selected image" }
        let alertController = UIAlertController(title: "Not finished", message:
            "\(alert)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}