//
//  ObjectPresenter.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ObjectPresenter -
class ObjectPresenter {

    weak var view: ObjectViewInput!
    var interactor: ObjectInteractorInput!
    var router: ObjectRouterInput!
}

//MARK: - extension for ObjectViewOutput -
extension ObjectPresenter: ObjectViewOutput {
    
    func didSelectObjectMenuRow(objectMenu: ObjectMenu) {
        interactor.getProducts(objectMenu)
    }
}

//MARK: - extension for ObjectInteractorOutput -
extension ObjectPresenter: ObjectInteractorOutput {
    
    func productsDataIsReady(products: [Product]) {
        let vc = ProductViewController()
        _ = ProductModuleInitializer(viewController: vc)
        vc.products = products
        
        router.pushViewController(vc)
    }
 
}