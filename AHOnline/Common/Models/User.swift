//
//  User.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class User: Object {
    
    dynamic var id = 1
    dynamic var name: String!
    dynamic var image: String!
    dynamic var email: String!
    dynamic var phone: String!
    dynamic var isVerified: Bool = false

    dynamic var address: DeliveryAddress?
    
    var favorites = List<Product>()
    var history = List<Product>()

    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id                 = data["id"].intValue
        self.name               = data["name"].stringValue
        self.image              = data["image"].stringValue
        self.email              = data["email"].stringValue
        self.phone              = data["mobile_number"].stringValue
        self.isVerified         = data["is_verified"].boolValue
    }
    
    func update(userInfo: UserInfo) {
        self.name               = userInfo.name
        self.image              = userInfo.image
        self.email              = userInfo.email
        self.phone              = userInfo.phone
        self.isVerified         = userInfo.isVerified
        
        self.favorites          = userInfo.favorites
    }
}

class UserInfo {
    
    var name: String!
    var image: String!
    var email: String!
    var phone: String!
    var isVerified: Bool = false
    var favorites = List<Product>()

    init(data: JSON) {
        self.name               = data["name"].stringValue
        self.image              = data["image"].stringValue
        self.email              = data["email"].stringValue
        self.phone              = data["mobile_number"].stringValue
        self.isVerified         = data["is_verified"].boolValue
        
        for item in data["products"].arrayValue {
            favorites.append(Product(data: item))
        }
    }
}