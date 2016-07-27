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
    
    func changeInCategoryTab() {
        Wireframe.selectTabControllerForIndex(1)
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension CartRouter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        Wireframe.presentViewController(vc)
    }
}