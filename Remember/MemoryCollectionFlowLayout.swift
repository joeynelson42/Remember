//
//  MemoryCollectionFlowLayout.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class MemoryCollectionFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: 376, height: 566)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        return layoutAttributes
    }
}