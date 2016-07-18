//
//  Address.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Address: Object {
    
    dynamic var id = 0
    dynamic var restaurant_id = 0
    dynamic var name: String!
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id                 = data["id"].intValue
        self.restaurant_id      = data["restaurant_id"].intValue
        self.name               = data["name"].stringValue
        self.latitude           = data["latitude"].doubleValue
        self.longitude          = data["longitude"].doubleValue
    }
}