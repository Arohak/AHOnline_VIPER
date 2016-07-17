//
//  ProductPresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ProductPresenter -
class ProductPresenter {

    weak var view: ProductViewInput!
    var interactor: ProductInteractorInput!
    var router: ProductRouterInput!
}

//MARK: - extension for ProductViewOutput -
extension ProductPresenter: ProductViewOutput {
    
    func viewIsReady() {

    }
    
    func addProductBuy(product: Product) {
        interactor.addProductBuy(product)
    }
}

//MARK: - extension for ProductInteractorOutput -
extension ProductPresenter: ProductInteractorOutput {

}