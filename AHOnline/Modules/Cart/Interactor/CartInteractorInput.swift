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
    func updateOrder(product: Product, count: Int)
    func removeOrder(product: Product)
    func removeOrders(products: List<Product>)
    func addCartInHistory(cart: Cart)
    
}
