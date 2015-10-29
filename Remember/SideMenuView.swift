//
//  SideMenuView.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

enum boxType{
    case settings
    case friends
    case user
    case notifications
    case list
}

class SideMenuView: UIView {
    
    var boxes: [SideMenuBox]!
    var boxTypes = [boxType.list, boxType.notifications, boxType.user, boxType.friends, boxType.settings]
    var boxSize = CGRect(x: 0, y: 0, width: 85, height: 85)
    
    init(frame: CGRect, boxCount: Int) {
        super.init(frame: frame)
        boxes = [SideMenuBox]()
        for boxType in boxTypes{
            let box = SideMenuBox(frame: boxSize, boxtype: boxType)
            boxes.append(box)
            self.addSubview((box as UIView))
            //constrain box to the previous box? or just to SideMenuView?
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openMenu(){
        
    }
    
    func slideIn(slideNext: () -> ()){
        
    }
    
    func slideOut(slideNext: () -> ()){
        
    }
    
    
    
}

class SideMenuBox: UIView{
    var type: boxType!
    
    init(frame: CGRect, boxtype: boxType){
        type = boxtype
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func slideBoxIn(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.transform = CGAffineTransformMakeTranslation(90, 0)
        }), completion: nil)
    }
    
    func slideBoxOut(){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
            self.transform = CGAffineTransformMakeTranslation(-90, 0)
        }), completion: nil)
    }
}











