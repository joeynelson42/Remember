//
//  NSDate+Remember.swift
//  Remember
//
//  Created by Joey on 11/3/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

extension NSDate{
    
    func day() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let day = calendar.components([.Day], fromDate: self)
        return day.day
    }
    
    func month() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.components([.Month], fromDate: self)
        return month.month
    }
    
    func year() -> Int{
        let calendar = NSCalendar.currentCalendar()
        let year = calendar.components([.Year], fromDate: self)
        return year.year
    }
    
    func fullDate() -> String{
        return "\(self.monthName()) \(self.day()), \(self.year())"
    }
    
    func monthAbbrev() -> String{
        switch self.month(){
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return "Invalid month number ya ding dong"
        }
    }
    
    func monthName() -> String{
        switch self.month(){
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "Invalid month number ya ding dong"
        }
    }
}