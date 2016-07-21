//
//  User.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class User: Object {
    
    dynamic var id = 0
    dynamic var name: String!
    dynamic var src: String!
    dynamic var address: Address!
    var favorite = List<Product>()
    var history = List<Product>()

    override static func primaryKey() -> String {
        return "name"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id                 = data["id"].intValue
        self.name               = data["name"].stringValue
        self.src                = data["src"].stringValue
        self.address            = Address(data: data["address"])
//        self.favorite           = data["favorite"].arrayObject as! List<Product>
//        self.history            = data["history"].arrayObject as! List<Product>
    }
}