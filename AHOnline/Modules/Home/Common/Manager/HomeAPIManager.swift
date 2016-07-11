//
//  HomeAPIManager.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct HomeAPIManager {
    
    private struct ROUTERS
    {
        static let GET_RESTAURANTS_HOME                     = "restaurants/home"
    }
    
    static func getRestaurantsHome() -> Observable<JSON> {
        
        return apiHelper.request(.GET, url: ROUTERS.GET_RESTAURANTS_HOME)
    }
}
