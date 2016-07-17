//
//  CartViewInput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CartViewInput: class {

    func deliveriesComing(deliveries: [Delivery])
    func ordersComing(orders: [Product], ordersPrice: Double)
    func ordersTotalPrice(ordersPrice: Double)
}
