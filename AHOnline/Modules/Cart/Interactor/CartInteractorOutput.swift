//
//  CartInteractorOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CartInteractorOutput: class {

    func deliveriesDataIsReady(deliveries: [Delivery])
    func ordersDataIsReady(orders: [Product], ordersPrice: Double)
    func ordersPriceDataIsReady(ordersPrice: Double)
}
