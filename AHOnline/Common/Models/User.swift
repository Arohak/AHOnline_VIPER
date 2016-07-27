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
    dynamic var image: String!
    dynamic var email: String!
    dynamic var phone: String!

    var address: DeliveryAddress?
    
    var favorite = List<Product>()
    var history = List<Product>()

    override static func primaryKey() -> String {
        return "name"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id                 = data["id"].intValue
        self.name               = data["name"].stringValue
        self.image              = data["image"].stringValue
        self.email              = data["email"].stringValue
        self.phone              = data["phone"].stringValue
    }
}