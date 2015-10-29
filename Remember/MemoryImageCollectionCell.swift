//
//  MemoryImageCollectionCell.swift
//  Remember
//
//  Created by Nelson, J. Edmond on 10/29/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

enum imageOrientation{
    case portrait
    case landscape
}

class MemoryImageCollectionCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var orientation: imageOrientation!
    
    
}