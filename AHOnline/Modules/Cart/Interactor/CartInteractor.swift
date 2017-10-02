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
        return DBHelper.getUserCart()
    }
}

//MARK: - extension for CartInteractorInput -
extension CartInteractor: CartInteractorInput {
    
    func getUser() {
        if let user = user {
            output.userDataIsReady(user: user)
        }
    }
    
    func getDeliveries() {
        _ = DeliveryEndpoint.getDeliveries()
            .subscribe(onNext: { result in
                if let result = result {
                    var deliveries: [Delivery] = []
                    for item in result["data"].arrayValue {
                        deliveries.append(Delivery(data: item))
                    }
                    
                    DBHelper.storeDeliveries(deliveries: deliveries)
                }
            })
    }
    
    func updateCartInfo(phone mobileNumber: String, address: String, city: String, alias: String, deliveryPrice: Double, date: Date, payment: String) {
        DBHelper.updateCartInfo(mobileNumber: mobileNumber, address: address, city: city, alias: alias, deliveryPrice: deliveryPrice, date: date, payment: payment)
    }
    
    func updateOrder(product: Product, count: Int) {
        DBHelper.updateOrder(product: product, count: count)
        
        output.updatePriceIsReady()
    }
    
    func removeOrder(product: Product) {
        DBHelper.removeOrder(product: product)
        
        output.updatePriceIsReady()
    }
    
    func removeOrders() {
        DBHelper.removeOrders()
    }
    
    func send(number: String) {
        if let user = user {
            _ = UserEndpoint.sendPhone("\(user.id)", number: number)
                .subscribe(onNext: { result in
                    if let result = result {
                        self.output.sendPhoneIsReady()
                    }
                })
        }
    }
    
    func accept(pin: String) {
        _ = UserEndpoint.verifyPhone(pin)
            .subscribe(onNext: { result in
                if let result = result {
                    let userInfo = UserInfo(data: result["data"])
                    DBHelper.updateUser(userInfo: userInfo)
                    
                    self.output.acceptDataIsReady()
                }
            })
    }
    
    func addOrdernHistory(historyOrder: HistoryOrder) {
        if let user = user {
            _ = OrderEndpoint.createOrder("\(user.id)", order: historyOrder)
                .subscribe(onNext: { result in
                    if let result = result {
                        let history = HistoryOrder(data: result["data"])
                        DBHelper.storeHistoryOrder(historyOrder: history)
                        DBHelper.removeOrders()
                        
                        self.output.placeOrderIsReady()
                    }
                })
        }
    }
}
