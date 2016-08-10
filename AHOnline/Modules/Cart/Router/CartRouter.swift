//
//  CartRouter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for CartRouter -
class CartRouter {

}

//MARK: - extension for CartRouterInput -
extension CartRouter: CartRouterInput {

}

//MARK: - extension for PresentViewControllerProtocol -
extension CartRouter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        Wireframe.presentViewController(vc)
    }
}

//MARK: - extension for SelectTabControllerProtocol -
extension CartRouter: SelectTabControllerProtocol {
    
    func selectTabControllerForIndex(index: Int) {
        Wireframe.selectTabControllerForIndex(index)
    }
}