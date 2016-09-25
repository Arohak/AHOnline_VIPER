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
    dynamic var alias: String!
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
        self.alias              = data["alias"].stringValue
        self.add                = data["address"].stringValue
        self.def                = data["default"].boolValue
    }
    
    func update(info: DeliveryAddressInfo) {
        self.country            = info.country
        self.city               = info.city
        self.alias              = info.alias
        self.add                = info.add
        self.def                = info.def
    }
}

class DeliveryAddressInfo {
    
    var country: String!
    var city: String!
    var alias: String!
    var add: String!
    var def: Bool = false
    
    init(data: JSON) {
        self.country            = data["country"].stringValue
        self.city               = data["city"].stringValue
        self.alias              = data["alias"].stringValue
        self.add                = data["address"].stringValue
        self.def                = data["default"].boolValue
    }
}