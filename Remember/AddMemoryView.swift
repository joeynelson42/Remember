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
    @IBOutlet weak var moveStoryDownbutton: UIButton!
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var startDateButton: UIButton!
    
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var calendarVisible = true
    var endDateVisible = false
    
    var CALENDAR_MOVE_DISTANCE: CGFloat!
    var END_DATE_MOVE_DISTANCE: CGFloat!
    
    var keyboardHeight: CGFloat!
    
    override func layoutSubviews() {
        
        navBar.backgroundColor = UIColor.fromHex(0x646363, alpha: 0.7)
        imageCollectionView.backgroundColor = UIColor.fromHex(0x646363, alpha: 0.5)

        
        
        calendarContainer.layer.cornerRadius = 3.0
        calendarContainer.layer.zPosition = CGFloat(MAXFLOAT - 1)
        
        endDateView.layer.cornerRadius = 3.0
        endDateView.layer.shadowColor = CGColor.fromHex(0x434242, alpha: 1.0)
        endDateView.layer.shadowOffset = CGSize(width: 0, height: -4)
        endDateView.layer.shadowOpacity = 0.2
        endDateView.layer.shadowRadius = 0.9
        
        startDateView.layer.cornerRadius = 3.0
//        startDateView.layer.shadowColor = CGColor.fromHex(0x434242, alpha: 1.0)
//        startDateView.layer.shadowOffset = CGSize(width: 3, height: -4)
//        startDateView.layer.shadowOpacity = 0.2
//        startDateView.layer.shadowRadius = 0.9
        
        story.layer.cornerRadius = 3.0
    }
    
    func calculateAnimationDistance(){
        let modelName = UIDevice.currentDevice().modelName
        switch modelName{
        case "iPhone 5", "iPhone 5s":
            CALENDAR_MOVE_DISTANCE = 500
            END_DATE_MOVE_DISTANCE = -150
            keyboardHeight = 253
        case "iPhone 6", "iPhone 6s":
            CALENDAR_MOVE_DISTANCE = 500
            END_DATE_MOVE_DISTANCE = -150
            keyboardHeight = 225
        case "iPhone 6 Plus", "iPhone 6s Plus":
            CALENDAR_MOVE_DISTANCE = 500
            END_DATE_MOVE_DISTANCE = -150
            keyboardHeight = 271
        case "Simulator":
            CALENDAR_MOVE_DISTANCE = 500
            END_DATE_MOVE_DISTANCE = -150
            keyboardHeight = 225
        default:
            return
        }
    }
    
    
    //MARK: Story/Quotes
    @IBAction func toggleStory(sender: UIButton) {
        storyButton.setTitleColor(UIColor.fromHex(0xF5FF93), forState: .Normal)
        quotesButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        story.hidden = false
        self.endEditing(true)
    }
    
    
    @IBAction func toggleQuotes(sender: UIButton) {
        quotesButton.setTitleColor(UIColor.fromHex(0xF5FF93), forState: .Normal)
        storyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        story.hidden = true
        self.endEditing(true)

    }
    
    func moveContainer(moveUp: Bool, keyboardHeight: CGFloat){
        if moveUp{
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: {(
                self.moveStoryDownbutton.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight),
                self.moveStoryDownbutton.alpha = 1.0,
                self.story.transform = CGAffineTransformMakeTranslation(0, -keyboardHeight),
                self.story.backgroundColor = UIColor.fromHex(0x646363, alpha: 1.0)
                )}, completion: nil)
        }
        else{
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: {(
                self.moveStoryDownbutton.transform = CGAffineTransformMakeTranslation(0, 0),
                self.moveStoryDownbutton.alpha = 0.0,
                self.story.transform = CGAffineTransformMakeTranslation(0, 0),
                self.story.backgroundColor = UIColor.fromHex(0x646363, alpha: 0.7)
                )}, completion: nil)
        }
    }
    
    @IBAction func moveStoryDown(sender: UIButton) {
        moveContainer(false, keyboardHeight: keyboardHeight)
        self.endEditing(true)
    }
    
    //MARK: Calendar
    
    func setDate(){
        let startDate = startPicker.date
        let endDate = endPicker.date
        var date = ""
        
        if(startDate == endDate || !endDateVisible){
            date = "\(startDate.fullDate())"
        }
        else if(startDate.year() != endDate.year()){
            date = "\(startDate.monthAbbrev()) \(startDate.day()), \(startDate.year()) - \(endDate.monthAbbrev()) \(endDate.day()), \(endDate.year())"
        }
        else if startDate.month() == endDate.month(){
            date = "\(startDate.monthName()) \(startDate.day())-\(endDate.day()), \(startDate.year())"
        }
        else{
            date = "\(startDate.monthAbbrev()) \(startDate.day())-\(endDate.monthAbbrev()) \(endDate.day()), \(startDate.year())"
        }
        
        dateButton.setTitle("\(date)", forState: .Normal)
    }
    
    func toggleCalendar(){
        self.endEditing(true)
        if calendarVisible{
            hideCalendar()
        }
        else{
            showCalendar()
            if endDateVisible {showEndDate()}
        }
        calendarVisible = !calendarVisible
    }
    
    @IBAction func toggleCalendarContainer(sender: UIButton) {
        toggleCalendar()
        if !calendarVisible{
            setDate()
        }
    }
    
    @IBAction func toggleStartDate(sender: UIButton) {
        //TODO: Move the calender view up to show the start date view
        toggleCalendar()
        if !calendarVisible{
            setDate()
        }
    }
    
    @IBAction func toggleEndDate(sender: UIButton) {
        if endDateVisible{
            endDateButton.setTitleColor(UIColor.fromHex(0x646363), forState: .Normal)
            hideEndDate()
        }
        else{
            endDateButton.setTitleColor(UIColor.fromHex(0x000000), forState: .Normal)
            showEndDate()
        }
        
        endDateVisible = !endDateVisible
    }
    
    func hideCalendar(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.calendarContainer.transform = CGAffineTransformMakeTranslation(0, self.CALENDAR_MOVE_DISTANCE)
        }), completion: nil)
        
    }
    
    func showCalendar(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.calendarContainer.transform = CGAffineTransformMakeTranslation(0, 0)
        }), completion: nil)
    }
    
    func showEndDate(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.calendarContainer.transform = CGAffineTransformMakeTranslation(0, self.END_DATE_MOVE_DISTANCE)
        }), completion: nil)
    }
    
    func hideEndDate(){
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.calendarContainer.transform = CGAffineTransformMakeTranslation(0, 0)
        }), completion: nil)
    }
    
    
    
    
    
    
}