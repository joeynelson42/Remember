//
//  MemoryCollectionCell.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class MemoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var memory: LocalMemory!
    var deleteEnabled = false
    weak var memoryCollectionVC: MemoryCollectionViewController!
    let OFFSET_SPEED: CGFloat = 15.0
    
    @IBAction func deleteAction(sender: AnyObject) {
        ParseServerProxy.parseProxy.deleteMemory(memory)
        
        for (i, mem) in memoryCollectionVC.memories.enumerate() {
            if mem.ID == memory.ID{
                memoryCollectionVC.memories.removeAtIndex(i)
            }
        }
        memoryCollectionVC.memoryCollection.reloadData()
        hideDelete()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //add the swipe gesture recognizers for toggling delete
        let Rswipe = UISwipeGestureRecognizer(target: self, action: "hideDelete")
        Rswipe.direction = UISwipeGestureRecognizerDirection.Right
        
        let Lswipe = UISwipeGestureRecognizer(target: self, action: "showDelete")
        Lswipe.direction = UISwipeGestureRecognizerDirection.Left
        
        self.addGestureRecognizer(Rswipe)
        self.addGestureRecognizer(Lswipe)
    }
    
    func hideDelete(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .CurveEaseIn, animations: {
            self.deleteButton.transform = CGAffineTransformMakeTranslation(118, 0)
            }, completion: nil)
        deleteEnabled = false
    }
    
    func showDelete(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .CurveEaseIn, animations: {
            self.deleteButton.transform = CGAffineTransformMakeTranslation(-118, 0)
            }, completion: nil)
        deleteEnabled = true
    }
    
    
    //for parallax effect
    func offset(offset: CGPoint){
        image.frame = CGRectOffset(self.image.bounds, offset.x, offset.y)
    }
}