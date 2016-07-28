//
//  NavigationProtocol.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol PresentNavigationViewControllerProtocol {
    
    func presentNavigationViewController(vc: UIViewController)
}

protocol PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController)
}

protocol ModalPresentViewControllerProtocol {
    
    func modalPresentViewController(vc: UIViewController)
}

protocol PushViewControllerProtocol {
    
    func pushViewController(vc: UIViewController)
}

protocol DismissControllerProtocol {
    
    func dismissViewController()
}