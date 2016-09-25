//
//  Delivery.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Delivery: Object {
    
    dynamic var id = 0
    dynamic var city: String!
    dynamic var alias: String!
    dynamic var price = 0.0
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(data: JSON) {
        self.init()
        
        self.id                 = data["id"].intValue
        self.city               = data["city"].stringValue
        self.alias              = data["alias"].stringValue
        self.price              = data["price"].doubleValue
    }
}