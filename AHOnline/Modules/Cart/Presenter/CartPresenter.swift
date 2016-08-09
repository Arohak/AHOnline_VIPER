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
    
    func getUser() {
        interactor.getUser()
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
    
    func removeOrders() {
        interactor.removeOrders()
    }
    
    func placeOrder(historyOrder: HistoryOrder) {
        interactor.addOrdernHistory(historyOrder)
    }
}

//MARK: - extension for CartInteractorOutput -
extension CartPresenter: CartInteractorOutput {
 
    func deliveriesDataIsReady(deliveries: [Delivery]) {
        view.deliveriesComing(deliveries)
    }
    
    func userDataIsReady(user: User) {
        view.userComing(user)
    }
    
    func updatePriceIsReady() {
        view.updateTotalPrice()
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension CartPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc)
    }
}


