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
        static let CREATE_USER                              = "users"
        static let GET_USER                                 = "users/%@"
        static let SEND_PHONE                               = "send_phone"
        static let VERIFY_PHONE                             = "verify"
        
        static let CREATE_DELIVERY_ADDRESS                  = "deliveryaddresses"
        static let PUT_DELIVERY_ADDRESS                     = "deliveryaddresses/%@"

        static let GET_RESTAURANTS_HOME                     = "home"
        static let GET_CATEGORIES                           = "categories"
        static let GET_DELIVERIES                           = "deliveries"
        static let GET_PRODUCTS                             = "categoryitems/%@/products?limit=%@&offset=%@"
        static let GET_PRODUCTS_TYPE                        = "products?type=%@&limit=%@&offset=%@"
        static let GET_PRODUCTS_SEARCH                      = "products?search=%@&limit=%@&offset=%@"

        static let GET_OBJECTS                              = "categories/%@/subcategories/%@?limit=%@&offset=%@"
        static let GET_OBJECTS_TYPE                         = "restaurants?type=%@&limit=%@&offset=%@"
        static let GET_OBJECTS_LIMIT                        = "restaurants?type=all&limit=%@&offset=0"
        static let GET_OBJECTS_SEARCH                       = "restaurants?search=%@&limit=%@&offset=%@"
        static let GET_OBJECT                               = "restaurants/%@"
        static let GET_NEARST_OBJECTS                       = "nears_objects?latitude=%@&longitude=%@&km=%@"
    }
    
    static func createUser() -> Observable<JSON> {
        return apiHelper.request(.POST, url: ROUTERS.CREATE_USER)
    }
    
    static func getUser(id: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_USER, id)
        return apiHelper.request(.GET, url: url)
    }
    
    static func sendMobileNumber(json: JSON) -> Observable<JSON> {
        let params = ["id"                  : json["id"].stringValue,
                      "mobile_number"       : json["mobile_number"].stringValue]
        
        return apiHelper.request(.POST, url: ROUTERS.SEND_PHONE, parameters: params)
    }
    
    static func verifyMobileNumber(pin: String) -> Observable<JSON> {
        let params = ["verification_code"   : pin]
        
        return apiHelper.request(.POST, url: ROUTERS.VERIFY_PHONE, parameters: params)
    }

    static func createDeliveryAddress(json: JSON) -> Observable<JSON> {
        let params = ["user_id"             : json["user_id"].stringValue,
                      "country"             : json["country"].stringValue,
                      "city"                : json["city"].stringValue,
                      "address"             : json["address"].stringValue,
                      "def"                 : json["def"].stringValue]
        
        return apiHelper.request(.POST, url: ROUTERS.CREATE_DELIVERY_ADDRESS, parameters: params)
    }
    
    static func updateDeliveryAddress(id: String, json: JSON) -> Observable<JSON> {
        let params = ["user_id"             : json["user_id"].stringValue,
                      "country"             : json["country"].stringValue,
                      "city"                : json["city"].stringValue,
                      "address"             : json["address"].stringValue,
                      "def"                 : json["def"].stringValue]
        
        let url = String(format: ROUTERS.PUT_DELIVERY_ADDRESS, id)
        return apiHelper.request(.PUT, url: url, parameters: params)
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
    
    static func getProducts(json: JSON) -> Observable<JSON> {
        var URL = ""
        if !json["id"].stringValue.isEmpty  {
            URL = String(format: ROUTERS.GET_PRODUCTS,
                         json["id"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
            
        } else if !json["search"].stringValue.isEmpty  {
            URL = String(format: ROUTERS.GET_PRODUCTS_SEARCH,
                         json["search"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
            
        } else {
            URL = String(format: ROUTERS.GET_PRODUCTS_TYPE,
                         json["type"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
        }
        
        return apiHelper.request(.GET, url: URL)
    }
    
    static func getObjectsForLimit(limit: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_OBJECTS_LIMIT, limit)
        return apiHelper.request(.GET, url: url)
    }
    
    static func getObjects(json: JSON) -> Observable<JSON> {
        var URL = ""
        if !json["category_id"].stringValue.isEmpty  {
            URL = String(format: ROUTERS.GET_OBJECTS,
                         json["category_id"].stringValue,
                         json["subcategory_id"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
            
        } else if !json["search"].stringValue.isEmpty  {
            URL = String(format: ROUTERS.GET_OBJECTS_SEARCH,
                         json["search"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
            
        } else {
            URL = String(format: ROUTERS.GET_OBJECTS_TYPE,
                         json["type"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
        }

        return apiHelper.request(.GET, url: URL)
    }
    
    static func getNearsObjects(json: JSON) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_NEARST_OBJECTS,
                         json["latitude"].stringValue,
                         json["longitude"].stringValue,
                         json["km"].stringValue)
        
        return apiHelper.request(.GET, url: url)
    }
}
