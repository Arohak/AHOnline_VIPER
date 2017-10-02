//
//  Wireframe.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import UIKit

struct Wireframe {
    
    static var window: UIWindow? {
        get {
            return appDelegate.window
        }
        set {
            appDelegate.window = newValue
        }
    }
    
    static func start() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController =  TabBarViewController()
        window!.makeKeyAndVisible()
        let value = DBHelper.getOrderCounts()
        setBadge(value)
    }
    
    static func root() -> TabBarViewController {
        let rootViewController = window!.rootViewController as! TabBarViewController
        return rootViewController
    }
    
    static func selectedNavigation() -> UINavigationController {
        let nav = root().selectedViewController as! UINavigationController
        return nav
    }
    
    static func setBadge(_ value: Int) {
        let tabArray = root().tabBar.items as NSArray!
        let tabItem = tabArray?.object(at: 2) as! UITabBarItem
        tabItem.badgeValue = value == 0 ? nil : "\(value)"
    }
    
    static func instantiateViewControllerWith(identifier: String) -> UIViewController {
        return UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    static func dismiss() {
        if let nav = root().presentedViewController as? UINavigationController {
            nav.dismiss(animated: true, completion: nil)
        } else {
            root().dismiss(animated: true, completion: nil)
        }
    }
    
    static func present(_ vc: UIViewController) {
        if let nav = root().presentedViewController as? UINavigationController {
            nav.present(vc, animated: true, completion: nil)
        } else {
            root().present(vc, animated: true, completion: nil)
        }
    }
    
    static func modalPresent(_ vc: UIViewController) {
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        root().present(vc, animated: true, completion: nil)
    }
    
    static func presentNavigation(_ vc: UIViewController) {
        let nav = UINavigationController(rootViewController: vc)
        root().present(nav, animated: true, completion: nil)
    }
    
    static func push(_ vc: UIViewController) {
        if let nav = selectedNavigation().presentedViewController as? UINavigationController {
            nav.pushViewController(vc, animated: true)
        } else {
            selectedNavigation().pushViewController(vc, animated: true)
        }
    }
    
    static func selectTab(_ index: Int) {
        root().selectedIndex = index
    }
    
    static func getTab(_ index: Int) -> UIViewController {
        let nav = root().viewControllers![index] as! UINavigationController
        let vc = nav.viewControllers[0]

        return vc
    }
}

