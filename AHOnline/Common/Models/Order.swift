//
//  Order.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Order: Object {
    
    dynamic var id = 0
    dynamic var name: String!
    dynamic var amount: String!
    dynamic var price = 0
    dynamic var count = 0
    dynamic var src: String!
    
    var products = List<Product>()

    convenience init(data: JSON) {
        self.init()

        self.id                 = data["id"].intValue
        self.name               = data["name"].stringValue
        self.amount             = data["amount"].stringValue
        self.price              = data["price"].intValue
        self.count              = data["count"].intValue
        self.src                = data["src"].stringValue
    }
}