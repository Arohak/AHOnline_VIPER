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
    
    func getProducts(json: JSON) {
        interactor.getProducts(json)
    }

    func addProductBuy(product: Product) {
        interactor.addProductBuy(product)
    }
    
    func favoriteButtonClicked(product: Product) {
        interactor.updateFavoriteProduct(product)
    }
}

//MARK: - extension for ProductInteractorOutput -
extension ProductPresenter: ProductInteractorOutput {

    func productsDataIsReady(products: [Product], storedProducts: Results<Product>) {
        view.setupInitialState(products, storedProducts: storedProducts)
    }
}