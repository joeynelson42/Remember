//
//  MemoryCollectionView.swift
//  Remember
//
//  Created by Joey on 10/31/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit
import Parse

class MemoryCollectionView: UIView{
    
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var memoryCollection: UICollectionView!
    @IBOutlet weak var sideMenuView: SideMenuView!
    @IBOutlet weak var menuFade: UIView!
    
    //side menu tiles
    @IBOutlet weak var collectionTile: SideMenuTile!
    @IBOutlet weak var notificationsTile: SideMenuTile!
    @IBOutlet weak var friendsTile: SideMenuTile!
    @IBOutlet weak var profileTile: SideMenuTile!
    @IBOutlet weak var settingsTile: SideMenuTile!
    
    var controller: MemoryCollectionViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadTiles()
        navigationBar.layer.zPosition = CGFloat(MAXFLOAT)
        sideMenuView.hideMenu()
        sideMenuView.hidden = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissMenu")
        menuFade.addGestureRecognizer(tap)
    }
    
    //MARK: Search Bar
    func hideSearchBar(){
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.05, options: .CurveEaseOut, animations: {
                self.searchBar.transform = CGAffineTransformMakeTranslation(0, -60)
                self.searchBar.alpha = 0.0
                self.memoryCollection.transform = CGAffineTransformMakeTranslation(0, -60)
            }, completion: nil)
    }
    
    func showSearchBar(){
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.05, options: .CurveEaseOut, animations: {
            self.searchBar.transform = CGAffineTransformMakeTranslation(0, 0)
            self.searchBar.alpha = 1.0
            self.memoryCollection.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }
    
    //MARK: Side Menu
    func dismissMenu(){
        hideFade()
        sideMenuView.toggleMenu()
    }
    
    @IBAction func menuButton(sender: AnyObject) {
        sideMenuView.toggleMenu()
        toggleFade()
    }
    
    func toggleFade(){
        if menuFade.alpha == 0.0{
            showFade()
        }
        else{
            hideFade()
        }
    }
    
    func showFade(){
        UIView.animateWithDuration(0.3, animations: ({
            self.menuFade.alpha = 0.6
        }), completion: nil)
    }
    
    func hideFade(){
        UIView.animateWithDuration(0.5, animations: ({
            self.menuFade.alpha = 0.0
        }), completion: nil)
    }
    
    @IBAction func tileSelected(sender: UIButton) {
        
        
        switch sender.tag{
        case 0:
            print("Collection tapped")
            sideMenuView.tiles[sender.tag].tappedAnimation({self.dismissMenu()})
        case 1:
            print("Tutorial tapped")
            controller.showTutorial()
        case 2:
            print("Profile tapped")
            sideMenuView.tiles[sender.tag].tappedAnimation({self.showComingSoonAlert()})
        case 3:
            print("Settings tapped")
            sideMenuView.tiles[sender.tag].tappedAnimation({self.showComingSoonAlert()})
            controller.showSettings()
        case 4:
            sideMenuView.tiles[sender.tag].tappedAnimation()
            showLogoutConfirmation()
        default:
            print("nothing tapped")
        }
        
    }
    
    func showComingSoonAlert(){
        let alertController = UIAlertController(title: "Coming Soon!", message:
            "Check back soon!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showLogoutConfirmation(){
        let alertController = UIAlertController(title: "Are you sure you want to logout?", message:
            "", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes, log me out.", style: UIAlertActionStyle.Destructive, handler: { (alertController) -> Void in self.controller.logout() }))
        alertController.addAction(UIAlertAction(title: "No, I want to stay!", style: UIAlertActionStyle.Default,handler: nil))
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func logoutViaAlert(alert: UIAlertAction!){
        self.controller.logout()
    }
    
    func loadTiles(){
        if sideMenuView.tiles.isEmpty{
            let tiles = [collectionTile, notificationsTile, friendsTile, profileTile, settingsTile]
            
            for tile in tiles{
                if let newTile = tile{
                    
                    //configure the tiles
                    newTile.layer.borderWidth = 2.0
                    newTile.layer.borderColor = CGColor.fromHex(0xF8FAA0)
                    newTile.backgroundColor = UIColor.fromHex(0x646363)
                    newTile.layer.cornerRadius = 3.0
                    
                    self.sideMenuView.tiles.append(newTile)
                }
            }
        }
    }
}