//
//  SideMenu.swift
//  SideMenuDemo
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

enum viewStatus{
    case open
    case closed
}

class SideMenuView: UIView {
    
    var tiles = [SideMenuTile]()
    var status = viewStatus.open
    
    //MARK: -----Delay constant: time bewteen each tile sliding in--------------
    let DELAY_INC = 0.1
    
    func toggleMenu(){
        if status == .closed {
            slideIn()
            status = .open
        }
        else{
            status = .closed
            slideOut()
        }
    }
    
    func hideMenu(){
        status = viewStatus.closed
        let delay: NSTimeInterval = 0
        for (i, tile) in tiles.enumerate(){
            if tile != tiles.last {
                tile.slideTileOut(delay, slideNext: {self.tiles[i+1].slideTileOut(delay)})
            }
            else{
                tile.slideTileOut(delay)
            }
        }
    }
    
    func slideIn(){
        var delay: NSTimeInterval = 0
        for (i, tile) in tiles.enumerate(){
            if tile != tiles.last {
                tile.slideTileIn(delay, slideNext: {self.tiles[i+1].slideTileIn(delay)})
                delay += DELAY_INC
            }
            else{
                tile.slideTileIn(delay)
            }
        }
    }
    
    func slideOut(){
        var delay: NSTimeInterval = 0
        for (i, tile) in tiles.enumerate(){
            if tile != tiles.last {
                tile.slideTileOut(delay, slideNext: {self.tiles[i+1].slideTileOut(delay)})
                delay += DELAY_INC
            }
            else{
                tile.slideTileOut(delay)
            }
        }
        
    }
    
    
    
}

class SideMenuTile: UIView{
    
    
    //MARK: -----Animation Constants---------------------
    let DURATION: NSTimeInterval = 0.2
    let INITIAL_SPRING: CGFloat = 0.2
    let DAMPING: CGFloat = 0.5
    let ANIMATION_OPTION = UIViewAnimationOptions.CurveEaseInOut

    func slideTileIn(delay: NSTimeInterval){
        UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: self.DAMPING, initialSpringVelocity: self.INITIAL_SPRING, options: self.ANIMATION_OPTION, animations: ({
            self.transform = CGAffineTransformMakeTranslation(0, 0)
        }), completion: nil)
    }
    
    func slideTileIn(delay: NSTimeInterval, slideNext: () -> ()){
        UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: self.DAMPING, initialSpringVelocity: self.INITIAL_SPRING, options: self.ANIMATION_OPTION, animations: ({
            self.transform = CGAffineTransformMakeTranslation(0, 0)
        }), completion: { finished in
            slideNext()
        })
    }
    
    func slideTileOut(delay: NSTimeInterval){
        UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: self.DAMPING, initialSpringVelocity: self.INITIAL_SPRING, options: self.ANIMATION_OPTION, animations: ({
            self.transform = CGAffineTransformMakeTranslation(-100, 0)
        }), completion: nil)
    }
    
    func slideTileOut(delay: NSTimeInterval, slideNext: () -> ()){
        UIView.animateWithDuration(0.5, delay: delay, usingSpringWithDamping: self.DAMPING, initialSpringVelocity: self.INITIAL_SPRING, options: self.ANIMATION_OPTION, animations: ({
            self.transform = CGAffineTransformMakeTranslation(-100, 0)
        }), completion: { finished in
            slideNext()
            
        })
    }
    
    func tappedAnimation(){
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseOut, animations: ({
            self.transform = CGAffineTransformMakeScale(0.85, 0.85)
        }), completion: {finished in
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseIn, animations: ({
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }), completion: nil)
        })
    }
}