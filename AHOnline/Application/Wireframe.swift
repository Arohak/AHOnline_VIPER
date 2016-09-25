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
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController =  TabBarViewController()
        window!.makeKeyAndVisible()
        
        setBadgeValue(value: DBManager.getOrderCounts())
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
        let tabItem = tabArray?.object(at: 2) as! UITabBarItem
        tabItem.badgeValue = value == 0 ? nil : "\(value)"
    }
    
    static func instantiateViewControllerWith(identifier: String) -> UIViewController {
        return UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    static func dismissViewController() {
        if let nav = root().presentedViewController as? UINavigationController {
            nav.dismiss(animated: true, completion: nil)
        } else {
            root().dismiss(animated: true, completion: nil)
        }
    }
    
    static func presentViewController(vc: UIViewController) {
        if let nav = root().presentedViewController as? UINavigationController {
            nav.present(vc, animated: true, completion: nil)
        } else {
            root().present(vc, animated: true, completion: nil)
        }
    }
    
    static func modalPresentViewController(vc: UIViewController) {
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        root().present(vc, animated: true, completion: nil)
    }
    
    static func presentNavigationController(vc: UIViewController) {
        let nav = UINavigationController(rootViewController: vc)
        root().present(nav, animated: true, completion: nil)
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

