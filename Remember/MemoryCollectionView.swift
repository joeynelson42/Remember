//
//  MemoryCollectionView.swift
//  Remember
//
//  Created by Joey on 10/31/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadTiles()
        sideMenuView.hideMenu()
        sideMenuView.hidden = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissMenu")
        menuFade.addGestureRecognizer(tap)
    }
    
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
        sideMenuView.tiles[sender.tag].tappedAnimation()
        
        switch sender.tag{
        case 0:
            print("Collection tapped")
            
        case 1:
            print("Notifications tapped")
        case 2:
            print("Friends tapped")
        case 3:
            print("Profile tapped")
        case 4:
            print("Settings tapped")
        default:
            print("nothing tapped")
        }
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