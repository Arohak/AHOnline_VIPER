//
//  Home.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class Home: Object {
    
    dynamic var name: String!
    
    var newRestaurants = List<Restaurant>()
    var rateRestaurants = List<Restaurant>()
    var openRestaurants = List<Restaurant>()

    override static func primaryKey() -> String {
        return "name"
    }
    
    convenience init(data: JSON) {
        self.init()
        
        for item in data["news"].arrayValue {
            newRestaurants.append(Restaurant(data: item))
        }
        for item in data["rates"].arrayValue {
            rateRestaurants.append(Restaurant(data: item))
        }
        for item in data["opens"].arrayValue {
            openRestaurants.append(Restaurant(data: item))
        }
    }
}