//
//  CartViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CartViewOutput: PresentViewControllerProtocol {

    func getOrders()
    func getDeliveries()
    func addOrder()
    func updateOrder(product: Product, count: Int)
    func removeOrder(product: Product)
    func removeOrders(products: [Product])
}
