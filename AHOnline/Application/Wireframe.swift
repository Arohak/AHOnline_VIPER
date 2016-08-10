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
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController =  TabBarViewController()
        window!.makeKeyAndVisible()
        
        setBadgeValue(DBManager.getOrderCounts())
    }
    
    static func login() {

    }
    
    static func root() -> TabBarViewController {
        let rootViewController = window!.rootViewController as! TabBarViewController
        return rootViewController
    }
    
    static func selectedNavigationController() -> UINavigationController {
        let nav = root().selectedViewController as! UINavigationController
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
        if let nav = root().presentedViewController as? UINavigationController {
            nav.dismissViewControllerAnimated(true, completion: nil)
        } else {
            root().dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    static func presentViewController(vc: UIViewController) {
        if let nav = root().presentedViewController as? UINavigationController {
            nav.presentViewController(vc, animated: true, completion: nil)
        } else {
            root().presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    static func modalPresentViewController(vc: UIViewController) {
        vc.modalTransitionStyle = .CrossDissolve
        vc.modalPresentationStyle = .OverCurrentContext
        root().presentViewController(vc, animated: true, completion: nil)
    }
    
    static func presentNavigationController(vc: UIViewController) {
        let nav = UINavigationController(rootViewController: vc)
        root().presentViewController(nav, animated: true, completion: nil)
    }
    
    static func pushViewController(vc: UIViewController) {
        selectedNavigationController().pushViewController(vc, animated: true)
    }
    
    static func selectTabControllerForIndex(index: Int) {
        root().selectedIndex = index
    }
    
    static func getTabControllerForIndex(index: Int) -> UIViewController {
        let nav = root().viewControllers![index] as! UINavigationController
        let vc = nav.viewControllers[0]

        return vc
    }
}

