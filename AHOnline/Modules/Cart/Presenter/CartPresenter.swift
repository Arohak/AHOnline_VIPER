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
        router.selectTabControllerForIndex(1)
    }
    
    func updateCart(mobileNumber: String, address: String, city: String, alias: String, deliveryPrice: Double, date: NSDate, payment: String) {
        interactor.updateCartInfo(mobileNumber, address: address, city: city, alias: alias, deliveryPrice: deliveryPrice, date: date, payment: payment)
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
    
    func sendMobileNumber(number: String) {
        interactor.send(number)
    }
    
    func acceptButtonClicked(pin: String) {
        interactor.accept(pin)
    }
    
    func placeOrder(historyOrder: HistoryOrder) {
        let payments = ["pay_on_delivery".localizedString,
                         "credit_cart".localizedString,
                         "paypal".localizedString]
        
        switch historyOrder.payment {
        case payments[0]:
            print(payments[0])
            interactor.addOrdernHistory(historyOrder)

        case payments[1]:
            print(payments[1])
            interactor.addOrdernHistory(historyOrder)

        default:
            interactor.addOrdernHistory(historyOrder)
        }
    }
}

//MARK: - extension for CartInteractorOutput -
extension CartPresenter: CartInteractorOutput {

    func userDataIsReady(user: User) {
        view.userComing(user)
    }
    
    func updatePriceIsReady() {
        view.updateTotalPrice()
    }
    
    func sendPhoneIsReady() {
        view.showAlertForVerify()
    }
    
    func acceptDataIsReady() {
        view.acceptVerification()
    }
    
    func placeOrderIsReady() {
        view.updateViewAfterPlaceOrder()
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension CartPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc)
    }
}


