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
}

//MARK: - extension for CartInteractorInput -
extension CartInteractor: CartInteractorInput {
    
    func getOrders() {
        let orders = DBManager.getOrders()
        output.ordersDataIsReady(Array(orders))
    }
    
    func updateOrder(product: Product, count: Int) {
        DBManager.updateOrder(product, count: count)
    }
    
    func removeOrder(product: Product) {
        DBManager.removeOrder(product)
    }
}