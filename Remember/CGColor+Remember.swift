//
//  CGColor+Remember.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

extension CGColor{
    class func fromHex(rgbValue:UInt32, alpha:Double=1.0) -> CGColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha)).CGColor
        
        return color
    }
    
    class func rememberYellow() -> CGColor{
        return fromHex(0xF5FF93)
    }
    
    class func rememberDarkGray() -> CGColor{
        return fromHex(0x666666)
    }
    
    class func rememberMidGray() -> CGColor{
        return fromHex(0x646363)
    }
    
    class func rememberGray() -> CGColor{
        return fromHex(0x979797)
    }
    
    class func rememberLightGray() -> CGColor{
        return fromHex(0xD8D8D8)
    }
    
    class func rememberRed() -> CGColor{
        return fromHex(0xA1423F)
    }
}