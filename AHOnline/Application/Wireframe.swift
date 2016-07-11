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
    }
    
    static func login() {

    }
    
    static func root() -> UINavigationController {
        let rootViewController = window!.rootViewController as! UINavigationController
        var navigationController = rootViewController
        if let nav = rootViewController.presentedViewController as? UINavigationController {
            navigationController = nav
        }
        
        return navigationController
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
    
    static func pushViewController(vc: UIViewController) {
        root().pushViewController(vc, animated: true)
    }
}

