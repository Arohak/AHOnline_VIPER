//
//  Wireframe.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct Wireframe {
    
    static var window = appDelegate.window
    
    static func start() {
        let tabBar = TabBarViewController()

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = tabBar
        window!.makeKeyAndVisible()
        
        setBadgeValue(DBManager.getOrderCounts())
    }
    
    static func login() {

    }
    
    static func root() -> TabBarViewController {
        let rootViewController = window!.rootViewController as! TabBarViewController
        return rootViewController
    }
    
    static func homeNavigationController() -> UINavigationController {
        let nav = root().viewControllers![0] as! UINavigationController
        return nav
    }
    
    static func categoryNavigationController() -> UINavigationController {
        let nav = root().viewControllers![1] as! UINavigationController
        return nav
    }
    
    static func setBadgeValue(value: Int) {
        let tabArray = root().tabBar.items as NSArray!
        let tabItem = tabArray.objectAtIndex(2) as! UITabBarItem
        tabItem.badgeValue = value == 0 ? nil : "\(value)"
    }
    
    static func instantiateViewControllerWith(identifier: String) -> UIViewController {
        return UIStoryboard(name: identifier, bundle: nil).instantiateViewControllerWithIdentifier(identifier)
    }
    
    static func dismissViewController() {
        root().dismissViewControllerAnimated(true, completion: nil)
    }
    
    static func presentViewController(vc: UIViewController) {
        root().presentViewController(vc, animated: true, completion: nil)
    }
    
    static func presentNavigationController(vc: UIViewController) {
        let nav = UINavigationController(rootViewController: vc)
        root().presentViewController(nav, animated: true, completion: nil)
    }
    
    static func pushViewController(from: UINavigationController, vc: UIViewController) {
        from.pushViewController(vc, animated: true)
    }
    
    static func selectTabControllerForIndex(index: Int) {
        root().selectedIndex = index
    }
}

