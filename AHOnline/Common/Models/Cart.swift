//
//  Cart.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Cart: Object {

    dynamic var id                      = 0
    dynamic var mobileNumber            = "*"
    dynamic var deliveryCity            = "*"
    dynamic var deliveryAddress         = "*"
    dynamic var deliveryAlias           = ""
    dynamic var deliveryDate: NSDate!   = NSDate()
    dynamic var payment                 = "pay_on_delivery".localizedString
    dynamic var deliveryPrice           = 0.0
    dynamic var ordersTotalPrice        = 0.0
    dynamic var totalPrice: Double      = 0.0

    var deliveries = List<Delivery>()
    var products = List<Product>()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id = data["id"].intValue
    }
}