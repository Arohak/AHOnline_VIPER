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

    func getProducts(_ type: ProductsRequestType, json: JSON) {
        interactor.getProducts(type, params: json)
    }

    func addProductBuy(product: Product) {
        interactor.addProductBuy(product: product)
    }
    
    func favoriteButtonClicked(product: Product) {
        interactor.updateFavoriteProduct(product: product)
    }
}

//MARK: - extension for ProductInteractorOutput -
extension ProductPresenter: ProductInteractorOutput {

    func productsDataIsReady(products: [Product]) {
        view.setupInitialState(products: products)
    }
    
    func addProductIsReady(product: Product) {
        view.addProduct(product: product)
    }
    
    func updateProductIsReady(product: Product) {
        view.updateProduct(product: product)
    }
}
