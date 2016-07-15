//
//  CartPresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CartPresenter -
class CartPresenter {

    weak var view: CartViewInput!
    var interactor: CartInteractorInput!
    var router: CartRouterInput!
}

//MARK: - extension for CartViewOutput -
extension CartPresenter: CartViewOutput {
    
    func viewIsReady() {
        interactor.getOrders()
    }
    
    func updateOrder(product: Product, count: Int) {
        interactor.updateOrder(product, count: count)
    }
    
    func removeOrder(product: Product) {
        interactor.removeOrder(product)
    }
}

//MARK: - extension for CartInteractorOutput -
extension CartPresenter: CartInteractorOutput {
 
    func ordersDataIsReady(orders: [Product]) {
        view.setupInitialState(orders)
    }
}