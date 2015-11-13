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
    @IBOutlet weak var storyButton: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundFade: UIView!
    
    var parentVC = MemoryViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        storyView.layer.cornerRadius = 3.0
        storyView.backgroundColor = UIColor.fromHex(0x646363, alpha: 0.85)
        imageCollectionView.backgroundColor = UIColor.fromHex(0x646363, alpha: 0.5)
    }
    
    @IBAction func storyButtonAction(sender: UIButton) {
        storyButton.setTitleColor(UIColor.fromHex(0xF5FF93), forState: .Normal)
        storyView.hidden = false
    }
}






