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

        static let PUT_FAVORITE                             = "favorites/%@"

        static let GET_RESTAURANTS_HOME                     = "home"
        static let GET_CATEGORIES                           = "categories"
        static let GET_DELIVERIES                           = "deliveries"
        static let GET_PRODUCTS                             = "products?categoryitem_id=%@&limit=%@&offset=%@"
        static let GET_PRODUCTS_SEARCH                      = "products?search=%@&limit=%@&offset=%@"
        static let GET_PRODUCTS_FAVORITE                    = "products?user_id=%@&limit=%@&offset=%@"

        static let GET_OBJECTS                              = "categories/%@/subcategories/%@?limit=%@&offset=%@"
        static let GET_OBJECTS_TYPE                         = "restaurants?type=%@&limit=%@&offset=%@"
        static let GET_OBJECTS_LIMIT                        = "restaurants?type=all&limit=%@&offset=0"
        static let GET_OBJECTS_SEARCH                       = "restaurants?search=%@&limit=%@&offset=%@"
        static let GET_OBJECT                               = "restaurants/%@"
        static let GET_NEARST_OBJECTS                       = "nears_objects?latitude=%@&longitude=%@&km=%@"
        
        static let CREATE_ORDER                             = "orders"
        static let GET_ORDERS                               = "orders?user_id=%@"
    }
    
    //MARK: - User -
    static func createUser() -> Observable<JSON> {
        return apiHelper.request(method: .post, url: ROUTERS.CREATE_USER)
    }
    
    static func getUser(id: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_USER, id)
        return apiHelper.request(method: .get, url: url)
    }
    
    //MARK: - Mobile Number -
    static func sendMobileNumber(json: JSON) -> Observable<JSON> {
        let params = ["id"                  : json["id"].stringValue,
                      "mobile_number"       : json["mobile_number"].stringValue]
        
        return apiHelper.request(method: .post, url: ROUTERS.SEND_PHONE, parameters: params)
    }
    
    static func verifyMobileNumber(pin: String) -> Observable<JSON> {
        let params = ["verification_code"   : pin]
        
        return apiHelper.request(method: .post, url: ROUTERS.VERIFY_PHONE, parameters: params)
    }
    
    //MARK: - Favorite -
    static func updateFavoriteProduct(user_id: String, product_id: String) -> Observable<JSON> {
        let params = ["user_id" : user_id]
        let url = String(format: ROUTERS.PUT_FAVORITE, product_id)
        return apiHelper.request(method: .put, url: url, parameters: params, showProgress: false)
    }

    //MARK: - Delivery Address -
    static func createDeliveryAddress(json: JSON) -> Observable<JSON> {
        let params = ["user_id"             : json["user_id"].stringValue,
                      "country"             : json["country"].stringValue,
                      "city"                : json["city"].stringValue,
                      "alias"               : json["alias"].stringValue,
                      "address"             : json["address"].stringValue,
                      "def"                 : json["def"].stringValue]
        
        return apiHelper.request(method: .post, url: ROUTERS.CREATE_DELIVERY_ADDRESS, parameters: params)
    }
    
    static func updateDeliveryAddress(id: String, json: JSON) -> Observable<JSON> {
        let params = ["user_id"             : json["user_id"].stringValue,
                      "country"             : json["country"].stringValue,
                      "city"                : json["city"].stringValue,
                      "alias"               : json["alias"].stringValue,
                      "address"             : json["address"].stringValue,
                      "def"                 : json["def"].stringValue]
        
        let url = String(format: ROUTERS.PUT_DELIVERY_ADDRESS, id)
        return apiHelper.request(method: .put, url: url, parameters: params)
    }
    
    //MARK: - Restaurants -
    static func getRestaurantsHome() -> Observable<JSON> {
        return apiHelper.request(method: .get, url: ROUTERS.GET_RESTAURANTS_HOME)
    }
    
    //MARK: - Categories -
    static func getCategories() -> Observable<JSON> {
        return apiHelper.request(method: .get, url: ROUTERS.GET_CATEGORIES)
    }
    
    //MARK: - Deliveries -
    static func getDeliveries() -> Observable<JSON> {
        return apiHelper.request(method: .get, url: ROUTERS.GET_DELIVERIES)
    }
    
    //MARK: - Object -
    static func getObject(id: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_OBJECT, id)
        return apiHelper.request(method: .get, url: url)
    }
    
    //MARK: - Products -
    static func getProducts(requestType: RequestType, json: JSON) -> Observable<JSON> {
        var firstParam = ""
        var URL = ""
        
        switch requestType {
        case .ID:
            firstParam = json["id"].stringValue
            URL = ROUTERS.GET_PRODUCTS
            
        case .SEARCH:
            firstParam = json["search"].stringValue
            URL = ROUTERS.GET_PRODUCTS_SEARCH
            
        case .FAVORITE:
            firstParam = json["user_id"].stringValue
            URL = ROUTERS.GET_PRODUCTS_FAVORITE
        }
        
        let url = String(format: URL,
                     firstParam,
                     json["limit"].stringValue,
                     json["offset"].stringValue)
        
        return apiHelper.request(method: .get, url: url)
    }
    
    static func getObjectsForLimit(limit: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_OBJECTS_LIMIT, limit)
        return apiHelper.request(method: .get, url: url)
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

        return apiHelper.request(method: .get, url: URL)
    }
    
    static func getNearsObjects(json: JSON) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_NEARST_OBJECTS,
                         json["latitude"].stringValue,
                         json["longitude"].stringValue,
                         json["km"].stringValue)
        
        return apiHelper.request(method: .get, url: url)
    }
    
    //MARK: - Order -
    static func createOrder(user_id: String, order: HistoryOrder) -> Observable<JSON> {
        var historyProducts: [Dictionary<String, Int>] = []
        for historyProduct in Array(order.historyProducts) {
            let hash = ["product_id": historyProduct.productID,
                        "count_buy": historyProduct.countBuy]
            historyProducts.append(hash)
        }
        
        let params: [String: Any] = ["user_id"             : user_id,
                                     "title"               : order.title,
                                     "date_create"         : order.dateCreate,
                                     "mobile_number"       : order.mobileNumber,
                                     "delivery_address"    : order.deliveryAddress,
                                     "delivery_city"       : order.deliveryCity,
                                     "delivery_alias"      : order.deliveryAlias,
                                     "delivery_date"       : order.deliveryDate,
                                     "payment"             : order.payment,
                                     "orders_total_price"  : order.ordersTotalPrice,
                                     "delivery_price"      : order.deliveryPrice,
                                     "total_price"         : order.totalPrice,
                                     "is_verified"         : order.isVerified,
                                     "products"            : historyProducts]
        
        return apiHelper.request(method: .post, url: ROUTERS.CREATE_ORDER, parameters: params)
    }
    
    static func getOrders(user_id: String) -> Observable<JSON> {
        let url = String(format: ROUTERS.GET_ORDERS, user_id)
        return apiHelper.request(method: .get, url: url)
    }
}
