//
//  UIColor+Remember.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    class func fromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    class func rememberYellow() -> UIColor{
        return fromHex(0xF5FF93)
    }
    
    class func rememberDarkGray() -> UIColor{
        return fromHex(0x666666)
    }
    
    class func rememberMidGray() -> UIColor{
        return fromHex(0x646363)
    }
    
    class func rememberGray() -> UIColor{
        return fromHex(0x979797)
    }
    
    class func rememberLightGray() -> UIColor{
        return fromHex(0xD8D8D8)
    }
    
    class func rememberRed() -> UIColor{
        return fromHex(0xA1423F)
    }
}