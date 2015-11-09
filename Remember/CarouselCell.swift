//
//  CarouselCell.swift
//  FlashyFlashcards
//
//  Created by Joey on 11/6/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class CarouselCell: UIView{
    
    var imageView: UIImageView!

    override init(frame: CGRect){
        super.init(frame: frame)
        self.frame = frame
        self.imageView = UIImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}