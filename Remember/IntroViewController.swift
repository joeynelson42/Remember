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
    var identifiers: NSArray = ["collectionIntro", "addIntro", "memoryIntro"]
    
    
    override func viewDidLoad() {
        
        
        let pageControl = UIPageControl.appearance()
        pageControl.backgroundColor = UIColor.clearColor()
        pageControl.currentPageIndicatorTintColor = UIColor.fromHex(0x92D57F)
        pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
        
        self.dataSource = self
        self.delegate = self
        
        let startingViewController = self.viewControllerAtIndex(self.index)
        let viewControllers: NSArray = [startingViewController]
        self.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.view.backgroundColor = UIColor.fromHex(0xB2B2B2)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController! {
        
        if index == 0 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("appNameVC") as! CollectionIntroViewController
            return vc
        }
        
        if index == 1 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("categoryTutorialVC") as! AddIntroViewController
            return vc
        }
        
        if index == 2 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("studyTutorialVC") as! MemoryIntroViewController
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
    
}