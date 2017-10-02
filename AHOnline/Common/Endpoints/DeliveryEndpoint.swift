//
//  OrderEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol DeliveryEndpointProtocol {
    
    static func getDeliveries() -> Observable<JSON?>
    static func createDeliveryAddress(json: JSON) -> Observable<JSON?>
    static func updateDeliveryAddress(id: String, json: JSON) -> Observable<JSON?>
}

struct DeliveryEndpoint {
    
    enum Router {
        static let getDeliveryPrices        = "/deliveries"
        static let createDeliveryAddress    = "/deliveryaddresses"
        static let updateDeliveryAddress    = "/deliveryaddresses/%@"
    }
}

extension DeliveryEndpoint : DeliveryEndpointProtocol {

    static func getDeliveries() -> Observable<JSON?> {
        let url = Router.getDeliveryPrices
        
        return APIHelper.request(.get, url)
    }
    
    static func createDeliveryAddress(json: JSON) -> Observable<JSON?> {
        let url = Router.createDeliveryAddress
        let params = ["user_id"             : json["user_id"].stringValue,
                      "country"             : json["country"].stringValue,
                      "city"                : json["city"].stringValue,
                      "alias"               : json["alias"].stringValue,
                      "address"             : json["address"].stringValue,
                      "def"                 : json["def"].stringValue]
        
        return APIHelper.request(.post, url, params)
    }
    
    static func updateDeliveryAddress(id: String, json: JSON) -> Observable<JSON?> {
        let url = String(format: Router.updateDeliveryAddress, id)
        let params = ["user_id"             : json["user_id"].stringValue,
                      "country"             : json["country"].stringValue,
                      "city"                : json["city"].stringValue,
                      "alias"               : json["alias"].stringValue,
                      "address"             : json["address"].stringValue,
                      "def"                 : json["def"].stringValue]
        
        return APIHelper.request(.put, url, params)
    }
}
