//
//  AddMemoryView.swift
//  Remember
//
//  Created by Joey on 10/31/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class AddMemoryView: UIView{
    
    @IBOutlet weak var addTitleField: UITextField!
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var endDateView: UIView!
    
    @IBOutlet weak var storyButton: UIButton!
    @IBOutlet weak var quotesButton: UIButton!
    @IBOutlet weak var story: UITextView!
    
    

    var calendarVisible = true
    var startDateVisible = true
    var endDateVisible = true
    
    override func layoutSubviews() {
        
        calendarContainer.layer.cornerRadius = 3.0
        calendarContainer.layer.zPosition = CGFloat(MAXFLOAT - 1)
        
        endDateView.layer.cornerRadius = 3.0
        endDateView.layer.shadowColor = CGColor.fromHex(0x434242, alpha: 1.0)
        endDateView.layer.shadowOffset = CGSize(width: 0, height: -4)
        endDateView.layer.shadowOpacity = 0.2
        endDateView.layer.shadowRadius = 0.9
        
        startDateView.layer.cornerRadius = 3.0
        startDateView.layer.shadowColor = CGColor.fromHex(0x434242, alpha: 1.0)
        startDateView.layer.shadowOffset = CGSize(width: 0, height: -4)
        startDateView.layer.shadowOpacity = 0.2
        startDateView.layer.shadowRadius = 0.9
        startDateView.layer.zPosition = CGFloat(MAXFLOAT)
    }
    
    
    
    @IBAction func toggleStory(sender: UIButton) {
        storyButton.setTitleColor(UIColor.fromHex(0xF5FF93), forState: .Normal)
        quotesButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        story.hidden = false
    }
    
    
    @IBAction func toggleQuotes(sender: UIButton) {
        quotesButton.setTitleColor(UIColor.fromHex(0xF5FF93), forState: .Normal)
        storyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        story.hidden = true
    }
    
    func toggleCalendar(){
        if calendarVisible{
            if(endDateVisible){
                hideEndDate()
                endDateVisible = false
            }
            hideCalendar()
        }
        else{
            showCalendar()
        }
        
        calendarVisible = !calendarVisible
    }
    
    @IBAction func toggleCalendarContainer(sender: UIButton) {
        toggleCalendar()
    }
    
    @IBAction func toggleStartDate(sender: UIButton) {
        //TODO: Move the calender view up to show the start date view
        if startDateVisible{
            
        }
        else{
            
        }
        startDateVisible = !startDateVisible
    }
    
    @IBAction func toggleEndDate(sender: UIButton) {
        if endDateVisible{
            hideEndDate()
        }
        else{
            showEndDate()
        }
        
        endDateVisible = !endDateVisible
    }
    
    func hideCalendar(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.calendarContainer.transform = CGAffineTransformMakeTranslation(0, 290)
        }), completion: nil)
    }
    
    func showCalendar(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.calendarContainer.transform = CGAffineTransformMakeTranslation(0, 0)
        }), completion: nil)
    }
    
    func hideEndDate(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.endDateView.transform = CGAffineTransformMakeTranslation(0, 150)
        }), completion: nil)
    }
    
    func showEndDate(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.endDateView.transform = CGAffineTransformMakeTranslation(0, 0)
        }), completion: nil)
    }
    
    
}