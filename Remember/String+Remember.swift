//
//  String+Remember.swift
//  Remember
//
//  Created by Nelson, J. Edmond on 10/29/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation

extension String{
    static func randomStringWithLength (length : Int) -> NSString {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: length)
        for (var i = 0; i < length-3; i++) {
            let len = UInt32(letters.length)
            let rand = arc4random_uniform(len)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
            if i == 7 || i == 11 || i == 15 || i == 19 {
                randomString.appendString("-")
            }
        }
        randomString.appendString("GuildHall")
        return randomString
    }
}