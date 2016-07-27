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
    
    func getOrders() {
        interactor.getOrders()
    }
    
    func getDeliveries() {
        interactor.getDeliveries()
    }
    
    func addOrder() {
        router.changeInCategoryTab()
    }
    
    func updateOrder(product: Product, count: Int) {
        interactor.updateOrder(product, count: count)
    }
    
    func removeOrder(product: Product) {
        interactor.removeOrder(product)
    }
    
    func removeOrders(products: [Product]) {
        interactor.removeOrders(products)
    }
}

//MARK: - extension for CartInteractorOutput -
extension CartPresenter: CartInteractorOutput {
 
    func deliveriesDataIsReady(deliveries: [Delivery]) {
        view.deliveriesComing(deliveries)
    }
    
    func ordersDataIsReady(user: User, orders: [Product], ordersPrice: Double) {
        view.ordersComing(user, orders: orders, ordersPrice: ordersPrice)
    }
    
    func ordersPriceDataIsReady(ordersPrice: Double) {
        view.ordersTotalPrice(ordersPrice)
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension CartPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc)
    }
}


