//
//  AHObject.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class AHObject: Object {
    
    dynamic var id = 0
    dynamic var restaurant_id = 0
    dynamic var label: String!
    dynamic var desc: String!
    dynamic var hash_: String!
    dynamic var status: String!
    dynamic var position = 0
    dynamic var budget: String!
    dynamic var openTime: String!
    dynamic var closeTime: String!
    dynamic var src: String!
    dynamic var min_amount_order: String!
    dynamic var rate = 0
    dynamic var totalHours = 0
    dynamic var objectNew = false
    
    dynamic var img: String!
    var menus = List<ObjectMenu>()
    var addresses = List<Address>()
    
    override static func primaryKey() -> String {
        return "id"
    }

    convenience init(data: JSON) {
        self.init()

        self.id                     = data["id"].intValue
        self.restaurant_id          = data["restaurant_id"].intValue
        self.label                  = data["label"].stringValue
        self.desc                   = data["description"].stringValue
        self.hash_                  = data["hash_"].stringValue
        self.status                 = data["status"].stringValue
        self.position               = data["position"].intValue
        self.budget                 = data["budget"].stringValue
        self.openTime               = data["openTime"].stringValue
        self.closeTime              = data["closeTime"].stringValue
        self.src                    = data["src"].stringValue
        self.min_amount_order       = data["min_amount_order"].stringValue
        self.rate                   = data["rate"].intValue
        self.totalHours             = data["totalHours"].intValue
        self.objectNew              = data["new"].boolValue
        
        self.img                    = data["img"].stringValue
        
        for item in data["categoryitems"].arrayValue {
            menus.append(ObjectMenu(data: item))
        }
        for item in data["addresses"].arrayValue {
            addresses.append(Address(data: item))
        }
    }
}
