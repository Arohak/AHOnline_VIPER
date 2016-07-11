//
//  Category.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Category: Object {
    
    dynamic var name: String!
    var subCategories = List<SubCategory>()
    
    override static func primaryKey() -> String {
        return "name"
    }
    
    convenience init(data: JSON) {
        self.init()
        
        self.name       = data["name"].stringValue
        
        for item in data["sub_categories"].arrayValue {
            subCategories.append(SubCategory(data: item))
        }
    }
}