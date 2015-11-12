//
//  IntroViewController.swift
//  Remember
//
//  Created by Joey on 11/11/15.
//  Copyright © 2015 NelsonJE. All rights reserved.
//

import Foundation
import UIKit

class IntroViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    
    var index = 0
    var identifiers: NSArray = ["appIntro", "collectionIntro", "memoryIntro", "addIntro"]
    
    
    override func viewDidLoad() {
        
        
        let pageControl = UIPageControl.appearance()
        pageControl.backgroundColor = UIColor.clearColor()
        pageControl.currentPageIndicatorTintColor = UIColor.fromHex(0xF8FAA0)
        pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
        
        self.dataSource = self
        self.delegate = self
        
        let startingViewController = self.viewControllerAtIndex(self.index)
        let viewControllers: NSArray = [startingViewController]
        self.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        
        
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController! {
        
        if index == 0 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("appIntro") as! AppIntroViewController
            return vc
        }
        
        if index == 1 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("collectionIntro") as! CollectionIntroViewController
            return vc
        }
        
        if index == 2 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("memoryIntro") as! MemoryIntroViewController
            return vc
        }
        
        if index == 3 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("addIntro") as! AddIntroViewController
            return vc
        }
        
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.indexOfObject(identifier!)
        
        //if the index is the end of the array, return nil since we dont want a view controller after the last one
        switch index{
        case 0:
            self.index = 1
            return self.viewControllerAtIndex(1)
        case 1:
            self.index = 2
            return self.viewControllerAtIndex(2)
        case 2:
            self.index = 3
            return self.viewControllerAtIndex(3)
        case 3:
            return nil
        default:
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.indexOfObject(identifier!)
        
        //if the index is 0, return nil since we dont want a view controller before the first one
        switch index{
        case 0:
            return nil
        case 1:
            self.index = 0
            return self.viewControllerAtIndex(0)
        case 2:
            self.index = 1
            return self.viewControllerAtIndex(1)
        case 3:
            self.index = 2
            return self.viewControllerAtIndex(2)
        default:
            return nil
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.identifiers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}