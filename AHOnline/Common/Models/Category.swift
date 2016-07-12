//
//  Category.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Category: Object {
    
    dynamic var id = 0
    dynamic var name: String!
    var subCategories = List<SubCategory>()
    
    override static func primaryKey() -> String {
        return "name"
    }
    
    convenience init(data: JSON) {
        self.init()
        
        self.id         = data["id"].intValue
        self.name       = data["name"].stringValue
        
        for item in data["subcategories"].arrayValue {
            subCategories.append(SubCategory(data: item))
        }
    }
}