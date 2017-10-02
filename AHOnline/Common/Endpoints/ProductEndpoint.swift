//
//  ProductEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol ProductEndpointProtocol {
    
    static func getProducts(_ requestType: ProductsRequestType, json: JSON) -> Observable<JSON?>
}

struct ProductEndpoint {
    
    enum Router {
        static let getProducts      = "/products?categoryitem_id=%@&limit=%@&offset=%@"
        static let searchProducts   = "/products?search=%@&limit=%@&offset=%@"
        static let favoriteProducts = "/products?user_id=%@&limit=%@&offset=%@"
    }
}

extension ProductEndpoint : ProductEndpointProtocol {

    static func getProducts(_ requestType: ProductsRequestType, json: JSON) -> Observable<JSON?> {
        var firstParam = ""
        var URL = ""
        
        switch requestType {
        case .Default:
            firstParam = json["id"].stringValue
            URL = Router.getProducts
            
        case .Search:
            firstParam = json["search"].stringValue
            URL = Router.searchProducts
            
        case .Favorite:
            firstParam = json["user_id"].stringValue
            URL = Router.favoriteProducts
        }
        
        let url = String(format: URL,
                         firstParam,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
        
        return APIHelper.request(.get, url)
    }
}
