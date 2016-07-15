//
//  Product.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Product: Object {
    
    dynamic var id = 0
    dynamic var product_id = 0
    dynamic var rest_id = 0
    dynamic var categoryitem_id = 0
    dynamic var menu = 0
    dynamic var restaurant_menu_categories = 0
    dynamic var new = false
    dynamic var name: String!
    dynamic var content: String!
    dynamic var item_number = 0
    dynamic var inventory = 0
    dynamic var instock = 0
    dynamic var desired_stock = 0
    dynamic var price = 0
    dynamic var type: String!
    dynamic var alias: String!
    dynamic var keywords: String!
    dynamic var src: String!
    
    dynamic var amount: String = "$"
    dynamic var countBuy = 1
    dynamic var isBuy: Bool {
        return countBuy > 0
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id                             = data["id"].intValue
        self.product_id                     = data["product_id"].intValue
        self.rest_id                        = data["rest_id"].intValue
        self.categoryitem_id                = data["categoryitem_id"].intValue
        self.menu                           = data["menu"].intValue
        self.restaurant_menu_categories     = data["restaurant_menu_categories"].intValue
        self.new                            = data["new"].boolValue
        self.name                           = data["label"].stringValue
        self.content                        = data["content"].stringValue
        self.item_number                    = data["item_number"].intValue
        self.inventory                      = data["inventory"].intValue
        self.instock                        = data["instock"].intValue
        self.desired_stock                  = data["desired_stock"].intValue
        self.price                          = data["price"].intValue
        self.type                           = data["type_"].stringValue
        self.alias                          = data["alias"].stringValue
        self.keywords                       = data["keywords"].stringValue
        self.src                            = data["src"].stringValue
    }
}