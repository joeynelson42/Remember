//
//  ImageCarouselViewController.swift
//  Remember
//
//  Created by Joey on 11/9/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class ImageCarouselViewController: UIViewController, iCarouselDataSource, iCarouselDelegate{
    
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var carouselView: iCarousel!
    var images = [UIImage]()
    var initialIndex = 0
    
    var IMAGE_WIDTH: CGFloat = 0
    var IMAGE_HEIGHT: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carouselView.pagingEnabled = true
    }
    
    override func viewWillAppear(animated: Bool) {
        carouselView.scrollToItemAtIndex(initialIndex, animated: true)
    }
    
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return images.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        
        var itemView: CarouselCell
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            getCarouselCellSize()
            itemView = CarouselCell(frame:CGRect(x:0, y:0, width:IMAGE_WIDTH, height:IMAGE_HEIGHT))
            itemView.layer.cornerRadius = 3.0
            itemView.contentMode = .Center
            itemView.backgroundColor = UIColor.clearColor()
            itemView.imageView = UIImageView(image: images[index])
            itemView.imageView.frame = itemView.frame
            itemView.imageView.tag = 1
            itemView.imageView.contentMode = .ScaleAspectFit
            
//            itemView.layer.cornerRadius = 3.0
//            itemView.layer.shadowColor = UIColor.blackColor().CGColor
//            itemView.layer.shadowOpacity = 0.2
//            itemView.layer.shadowOffset = CGSizeMake(0, 10)
//            itemView.layer.shadowRadius = 10.0
            itemView.layer.masksToBounds = false
            
            itemView.addSubview(itemView.imageView)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view! as! CarouselCell
            itemView.imageView = itemView.viewWithTag(1) as! UIImageView!
        }
        
        let swipe = UISwipeGestureRecognizer(target: self, action: "exit")
        swipe.direction = .Down
        itemView.addGestureRecognizer(swipe)
        
        itemView.imageView.image = images[index]
        
        return itemView
    }
    
    func getCarouselCellSize(){
        
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
        
        
        IMAGE_WIDTH = screenWidth
        IMAGE_HEIGHT = screenHeight
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }
    
    func carouselDidScroll(carousel: iCarousel) {
        hideXButton()
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        toggleXButton()
    }
    
    func hideXButton(){
        if xButton.alpha == 1.0{
            UIView.animateWithDuration(0.5, animations: {
                self.xButton.alpha = 0.0
            })
        }
    }
    
    func showXButton(){
        if xButton.alpha == 0.0{
            UIView.animateWithDuration(0.5, animations: {
                self.xButton.alpha = 1.0
            })
        }
    }
    
    func toggleXButton(){
        var alpha: CGFloat = 0.0
        if xButton.alpha == 0{
            alpha = 1.0
        }
        
        
        UIView.animateWithDuration(0.5, animations: {
            self.xButton.alpha = alpha
        })
    }
    
    func exit(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func xButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}