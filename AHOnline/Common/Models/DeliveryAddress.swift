//
//  DeliveryAddress.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class DeliveryAddress: Object {
    
    dynamic var id = 0
    dynamic var country: String!
    dynamic var city: String!
    dynamic var add: String!
    dynamic var def: Bool = false

    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id                 = data["id"].intValue
        self.country            = data["country"].stringValue
        self.city               = data["city"].stringValue
        self.add                = data["add"].stringValue
        self.def                = data["default"].boolValue
    }
}