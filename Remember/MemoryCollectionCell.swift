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
    
    var memory: Memory!
}