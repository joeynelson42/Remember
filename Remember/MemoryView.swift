//
//  MemoryView.swift
//  Remember
//
//  Created by Joey on 11/3/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class MemoryView: UIView{
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var storyView: UITextView!
    @IBOutlet weak var quotesButton: UIButton!
    @IBOutlet weak var storyButton: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundFade: UIView!
    
    var parentVC = MemoryViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollectionView.backgroundColor = UIColor.fromHex(0x646363, alpha: 0.5)
    }
    
    @IBAction func storyButtonAction(sender: UIButton) {
        storyButton.setTitleColor(UIColor.fromHex(0xF5FF93), forState: .Normal)
        quotesButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        storyView.hidden = false
    }
    
    @IBAction func quotesButtonAction(sender: UIButton) {
        quotesButton.setTitleColor(UIColor.fromHex(0xF5FF93), forState: .Normal)
        storyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        storyView.hidden = true
    }
}






