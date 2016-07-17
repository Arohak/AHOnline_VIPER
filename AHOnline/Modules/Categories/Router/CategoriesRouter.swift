//
//  CategoriesRouter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for CategoriesRouter -
class CategoriesRouter {

}

//MARK: - extension for CategoriesRouterInput -
extension CategoriesRouter: CategoriesRouterInput {
    
    func presentNavigationViewController(vc: UIViewController) {
        Wireframe.presentNavigationController(vc)
    }
    
    func pushViewController(vc: UIViewController) {
        Wireframe.pushViewController(Wireframe.categoryNavigationController(), vc: vc)
    }
}