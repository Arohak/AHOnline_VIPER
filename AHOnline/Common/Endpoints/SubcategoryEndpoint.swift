//
//  SubcategoryEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol SubcategoryEndpointProtocol {
    
    static func getSubcategories(_ categoryId: String, limit: String, offset: String) -> Observable<JSON?>
}

struct SubcategoryEndpoint {
    
    enum Router {
        static let getSubcategories = "/categories/%@/subcategories/%@?limit=%@&offset=%@"
    }
}

extension SubcategoryEndpoint : SubcategoryEndpointProtocol {
 
    static let kLimit   = "20"
    static let kOffset  = "0"

    static func getSubcategories(_ categoryId: String, limit: String = kLimit, offset: String = kOffset) -> Observable<JSON?> {
        let url = String(format: Router.getSubcategories, categoryId, limit, offset)
    
        return APIHelper.request(.get, url)
    }
}
