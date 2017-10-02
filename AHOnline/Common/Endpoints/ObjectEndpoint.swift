//
//  ObjectEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol ObjectEndpointProtocol {
    
    static func getObjects(_ requestType: ObjectsRequestType, json: JSON) -> Observable<JSON?>
    static func getNeartObjects(_ json: JSON) -> Observable<JSON?>
    static func getObject(_ id: String) -> Observable<JSON?>
}

struct ObjectEndpoint {
    
    enum Router {
        static let getCategoryObjects   = "/categories/%@/subcategories/%@?limit=%@&offset=%@"
        static let getObjectsWithType   = "/restaurants?type=%@&limit=%@&offset=%@"
        static let getObjectsWithSearch = "/restaurants?search=%@&limit=%@&offset=%@"
        static let getNeartObjects      = "/nears_objects?latitude=%@&longitude=%@&km=%@"
        static let getObject            = "/restaurants/%@"
    }
}

extension ObjectEndpoint : ObjectEndpointProtocol {
    
    static func getObjects(_ requestType: ObjectsRequestType, json: JSON) -> Observable<JSON?> {
        var url = ""
        switch requestType {
        case .Category:
            url = String(format: Router.getCategoryObjects,
                         json["category_id"].stringValue,
                         json["subcategory_id"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
            
        case .WithType:
            url = String(format: Router.getObjectsWithType,
                         json["type"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
            
        case .WithSearch:
            url = String(format: Router.getObjectsWithSearch,
                         json["search"].stringValue,
                         json["limit"].stringValue,
                         json["offset"].stringValue)
            
        case .WithLimit:
            url = String(format: Router.getObjectsWithType,
                         "all",
                         "5",
                         "0")
        }
        
        return APIHelper.request(.get, url)
    }
    
    static func getNeartObjects(_ json: JSON) -> Observable<JSON?> {
        let url = String(format: Router.getNeartObjects,
                         json["latitude"].stringValue,
                         json["longitude"].stringValue,
                         json["km"].stringValue)
        
        return APIHelper.request(.get, url)
    }
    
    static func getObject(_ id: String) -> Observable<JSON?> {
        let url = String(format: Router.getObject, id)
        
        return APIHelper.request(.get, url)
    }
}
