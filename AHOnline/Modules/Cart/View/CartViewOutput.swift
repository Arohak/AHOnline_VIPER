//
//  CartViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CartViewOutput: PresentViewControllerProtocol {

    func getUser()
    func getDeliveries()
    func addOrder()
    
    func updateCart(phone: String, address: String, city: String, alias: String, deliveryPrice: Double, date: NSDate, payment: String)
    
    func updateOrder(product: Product, count: Int)
    func removeOrder(product: Product)
    func removeOrders()
    
    func sendMobileNumber(number: String)
    func acceptButtonClicked(pin: String)
    func placeOrder(historyOrder: HistoryOrder)
}
