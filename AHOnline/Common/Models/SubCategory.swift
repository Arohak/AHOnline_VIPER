//
//  SubCategory.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class SubCategory: Object {
    
    dynamic var name: String!
    dynamic var image: String!
    
    override static func primaryKey() -> String {
        return "name"
    }
    
    convenience init(data: JSON) {
        self.init()
        
        self.name       = data["name"].stringValue
        self.image      = data["image"].stringValue
    }
}