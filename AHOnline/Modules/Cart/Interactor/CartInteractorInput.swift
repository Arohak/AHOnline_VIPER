//
//  CartInteractorInput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CartInteractorInput {

    func getUser()
    func getDeliveries()
    func updateCartInfo(phone: String, address: String, city: String, alias: String, deliveryPrice: Double, date: NSDate, payment: String)
    func updateOrder(product: Product, count: Int)
    func removeOrder(product: Product)
    func removeOrders()
    func send(number: String)
    func accept(pin: String)
    func addOrdernHistory(historyOrder: HistoryOrder)
    
}
