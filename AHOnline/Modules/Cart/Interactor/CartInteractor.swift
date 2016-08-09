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
                    self.output.deliveriesDataIsReady(deliveries)
                }
                }, onError: { error in
                    let deliveries = DBManager.getDeliveries()
                    self.output.deliveriesDataIsReady(Array(deliveries))
            })
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
    
    func addOrdernHistory(historyOrder: HistoryOrder) {
        DBManager.storeHistoryOrder(historyOrder)
        DBManager.removeOrders()
    }
}