//
//  Cart.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Cart: Object {
    
    dynamic var id = 0
    dynamic var title: String!
    dynamic var totalPrice = 0.0
    dynamic var date: String!
    dynamic var mobileNumber: String!
    dynamic var time: String!
    dynamic var payment: String!
    
    dynamic var deliveryAddress: DeliveryAddress?
    var products = List<Product>()

    override static func primaryKey() -> String {
        return "date"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id             = data["id"].intValue
        self.title          = data["title"].stringValue
        self.totalPrice     = data["totalPrice"].doubleValue
        self.date           = data["date"].stringValue
        self.mobileNumber   = data["mobileNumber"].stringValue
        self.time           = data["time"].stringValue
        self.payment        = data["payment"].stringValue
        
        deliveryAddress     = data["address"].object as? DeliveryAddress
    }
}