//
//  DBManager.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct DBManager {
    
    private static let realm = dbHelper.realm
    
    //MARK: - Restaurants -
    static func storeRestaurants(restaurants: [Restaurant]) {
        try! realm.write {
            realm.add(restaurants, update: true)
        }
    }
}
