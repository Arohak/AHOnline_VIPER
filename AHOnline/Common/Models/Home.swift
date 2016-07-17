//
//  Home.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Home: Object {
    
    dynamic var name: String!
    
    var newRestaurants = List<AHObject>()
    var rateRestaurants = List<AHObject>()
    var openRestaurants = List<AHObject>()

    override static func primaryKey() -> String {
        return "name"
    }
    
    convenience init(data: JSON) {
        self.init()
        
        for item in data["news"].arrayValue {
            newRestaurants.append(AHObject(data: item))
        }
        for item in data["rates"].arrayValue {
            rateRestaurants.append(AHObject(data: item))
        }
        for item in data["opens"].arrayValue {
            openRestaurants.append(AHObject(data: item))
        }
    }
}