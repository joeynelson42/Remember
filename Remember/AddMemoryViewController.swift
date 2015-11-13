//
//  AddMemoryViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AddMemoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate{
    
    var memory: LocalMemory!
    var images = [UIImage]()
    let imagePicker = UIImagePickerController()
    let PORTRAIT_IMAGE_SIZE = CGSize(width: 130, height: 230)
    let LANDSCAPE_IMAGE_SIZE = CGSize(width: 230, height: 130)
    var keyboardHeight: CGFloat!
    var currentBGIndexPath: NSIndexPath!
    var collectionVC = MemoryCollectionViewController()
    var memoryVC = MemoryViewController()
    
    var swipe = UISwipeGestureRecognizer()

    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet var addMemoryView: AddMemoryView!
    @IBOutlet weak var progressContainer: UIView!
    
    var editMode = false
    
    override func viewDidLoad() {
        imagePicker.delegate = self
        registerForKeyboardNotifications()
        addMemoryView.controller = self
        
        swipe = UISwipeGestureRecognizer(target: self, action: "moveTextFieldDown")

        if let mem = memory{
            editMode = true
            images = memory.images
            addMemoryView.loadMemoryToBeEdited(mem)
        }
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        
        imageCollectionView.clipsToBounds = false
    
        self.imageCollectionView.addGestureRecognizer(lpgr)
        
        
        progressContainer.layer.cornerRadius = 5.0
        progressContainer.backgroundColor = UIColor.fromHex(0x434242, alpha: 0.7)
    }
    
    override func viewWillAppear(animated: Bool) {
        if addMemoryView.calendarVisible{
            addMemoryView.calculateAnimationDistance()
            addMemoryView.toggleCalendar()
        }
        
        progressContainer.alpha = 0.0
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
            
            cell.tag = indexPath.row
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
        else{
            let cellHeight: CGFloat = 226
            let cellWidth: CGFloat = (226 * images[indexPath.row].size.width) / images[indexPath.row].size.height
            
            return CGSize(width: cellWidth, height: cellHeight)
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
    
    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        let p = gestureReconizer.locationInView(self.imageCollectionView)
        let indexPath = self.imageCollectionView.indexPathForItemAtPoint(p)
        
        if gestureReconizer.state != UIGestureRecognizerState.Ended {
            if let index = indexPath {
                let cell = self.imageCollectionView.cellForItemAtIndexPath(index)
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
                    cell!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    }, completion: nil)
            }
        }
        else{
            if let index = indexPath {
                let cell = self.imageCollectionView.cellForItemAtIndexPath(index)
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
                    cell!.transform = CGAffineTransformMakeScale(0.001, 0.001)
                    }, completion: {finished in
                        
                        if let BGimage = self.addMemoryView.backgroundImageView.image{
                            if(self.images[index.row] == BGimage){
                                self.addMemoryView.backgroundImageView.image = nil
                            }
                        }
                        
                        
                        self.images.removeAtIndex(index.row)
                        self.imageCollectionView.reloadData()
                        
                })
                
                
            } else {
                print("Could not find index path")
            }
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
    
    func moveTextFieldDown(){
        self.addMemoryView.moveContainer(false, keyboardHeight: keyboardHeight)
        self.view.endEditing(true)
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
        swipe.direction = .Down
        self.view.addGestureRecognizer(swipe)
        
        if(textView.text == "Write the story..."){
            textView.text = ""
        }
        self.keyboardHeight = addMemoryView.keyboardHeight
        self.addMemoryView.moveContainer(true, keyboardHeight: keyboardHeight)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.view.removeGestureRecognizer(swipe)
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
    
    //MARK: Saving the Memory
    
    @IBAction func checkMarkButtonAction(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: {
            self.progressContainer.alpha = 1.0
            }, completion: {finished in
                if self.editMode{
                    self.updateMemory()
                }
                else{
                    self.saveMemory()
                }
        })
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
            memoryVC.images = newMemory.images
            memoryVC.imageCollectionView.reloadData()
            collectionVC.memoryCollectionView.memoryCollection.reloadData()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            notifyNotReady()
        }
    }
    
    func memoryReady() -> Bool{
        if(addMemoryView.addTitleField.text! == ""){ return false }
        if(addMemoryView.dateButton.titleLabel?.text == "Add Date..."){ return false }
        if(addMemoryView.story.text == "Write the story..."){ return false }
        if(self.images.count == 0) { return false }
        if(addMemoryView.backgroundImageView.image == nil){ return false }
        else{ return true }
    }
    
    func notifyNotReady(){
        UIView.animateWithDuration(0.3, animations: {
            self.progressContainer.alpha = 0.0
            }, completion: {finished in
                var alert = ""
                if(self.addMemoryView.addTitleField.text! == ""){ alert += "Add a title.\n" }
                if(self.addMemoryView.dateButton.titleLabel?.text == "Add Date..."){ alert += "Add a date.\n" }
                if(self.addMemoryView.story.text == "Write the story..."){ alert += "Write a story.\n" }
                if(self.images.count == 0){ alert += "Add (at least) one image.\n"}
                if(self.addMemoryView.backgroundImageView.image == nil){ alert += "Select an image as your memory's main photo.\n" }
                let alertController = UIAlertController(title: "Missing Field(s)", message:
                    "\(alert)", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
        })
    }
    
    @IBAction func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}