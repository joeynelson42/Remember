//
//  FriendsListViewController.swift
//  Remember
//
//  Created by Joey on 10/28/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit
import Parse

class FriendsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var friends = [PFUser]()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = FriendCollectionCell()
        cell.user = friends[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let userProfileVC = UserProfileViewController()
        self.presentViewController(userProfileVC, animated: true, completion: nil)
    }
    
    func addFriend(){
        
    }
}