//
//  CartInteractor.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CartInteractor -
class CartInteractor {

    weak var output: CartInteractorOutput!
    
    var user: User? {
        return DBManager.getUserCart()
    }
}

//MARK: - extension for CartInteractorInput -
extension CartInteractor: CartInteractorInput {
    
    func getUser() {
        if let user = user {
            output.userDataIsReady(user)
        }
    }
    
    func getDeliveries() {
        _ = APIManager.getDeliveries()
            .subscribe(onNext: { result in
                if result != nil {
                    var deliveries: [Delivery] = []
                    for item in result["data"].arrayValue {
                        deliveries.append(Delivery(data: item))
                    }
                    
                    DBManager.storeDeliveries(deliveries)
                }
            })
    }
    
    func updateCartInfo(mobileNumber: String, address: String, city: String, alias: String, deliveryPrice: Double, date: NSDate, payment: String) {
        DBManager.updateCartInfo(mobileNumber, address: address, city: city, alias: alias, deliveryPrice: deliveryPrice, date: date, payment: payment)
    }
    
    func updateOrder(product: Product, count: Int) {
        DBManager.updateOrder(product, count: count)
        
        output.updatePriceIsReady()
    }
    
    func removeOrder(product: Product) {
        DBManager.removeOrder(product)
        
        output.updatePriceIsReady()
    }
    
    func removeOrders() {
        DBManager.removeOrders()
    }
    
    func send(number: String) {
        if let user = user {
            let json = JSON([
                "id"            : user.id,
                "mobile_number" : number])
            
            _ = APIManager.sendMobileNumber(json)
                .subscribe(onNext: { result in
                    if result != nil {
                        self.output.sendPhoneIsReady()
                    }
                })
        }
    }
    
    func accept(pin: String) {
        _ = APIManager.verifyMobileNumber(pin)
            .subscribe(onNext: { result in
                if result != nil {
                    let userInfo = UserInfo(data: result["data"])
                    DBManager.updateUser(userInfo)
                    
                    self.output.acceptDataIsReady()
                }
            })
    }
    
    func addOrdernHistory(historyOrder: HistoryOrder) {
        //        _ = APIManager.createOrder(historyOrder)
        //            .subscribe(onNext: { result in
        //                if result != nil {
        //                    DBManager.storeHistoryOrder(historyOrder)
        //                    DBManager.removeOrders()
        //
        //                    output.removeCartIsReady()
        //                }
        //            })
        
        DBManager.storeHistoryOrder(historyOrder)
        DBManager.removeOrders()
        
        output.placeOrderIsReady()
    }
}