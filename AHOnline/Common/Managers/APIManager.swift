//
//  APIManager.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct APIManager {
    
    private struct ROUTERS
    {
        static let GET_RESTAURANTS_HOME                     = "home"
        static let GET_CATEGORIES                           = "categories"
        static let GET_DELIVERIES                           = "deliveries"
        static let GET_PRODUCTS                             = "categoryitems/%@/products"
        
        static let GET_OBJECTS                              = "categories/%@/subcategories/%@?limit=%@&offset=%@"
        static let GET_OBJECTS_TYPE                         = "restaurants?type=%@&limit=%@&offset=%@"
        static let GET_OBJECTS_LIMIT                        = "restaurants?type=all&limit=%@&offset=0"
        static let GET_OBJECT                               = "restaurants/%@"
        static let GET_NEARST_OBJECTS                       = "nears_objects?latitude=%@&longitude=%@&km=%@"
    }
    
    static func getRestaurantsHome() -> Observable<JSON> {
        return apiHelper.request(.GET, url: ROUTERS.GET_RESTAURANTS_HOME)
    }
    
    static func getCategories() -> Observable<JSON> {
        return apiHelper.request(.GET, url: ROUTERS.GET_CATEGORIES)
    }
    
    static func getDeliveries() -> Observable<JSON> {
        return apiHelper.request(.GET, url: ROUTERS.GET_DELIVERIES)
    }
    
    static func getObject(id: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_OBJECT, id)
        return apiHelper.request(.GET, url: url)
    }
    
    static func getProducts(id: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_PRODUCTS, id)
        return apiHelper.request(.GET, url: url)
    }
    
    static func getObjectsForLimit(limit: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_OBJECTS_LIMIT, limit)
        return apiHelper.request(.GET, url: url)
    }
    
    static func getObjects(json: JSON) -> Observable<JSON> {
        var URL = ""
        if json["category_id"].stringValue.isEmpty  {
            URL = String(format: ROUTERS.GET_OBJECTS_TYPE,
                         json["type"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
        } else {
            URL = String(format: ROUTERS.GET_OBJECTS,
                         json["category_id"].stringValue,
                         json["subcategory_id"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
        }

        return apiHelper.request(.GET, url: URL, showProgress: true)
    }
    
    static func getNearsObjects(json: JSON) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_NEARST_OBJECTS,
                         json["latitude"].stringValue,
                         json["longitude"].stringValue,
                         json["km"].stringValue)
        
        return apiHelper.request(.GET, url: url)
    }
}
