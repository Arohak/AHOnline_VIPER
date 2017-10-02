//
//  CategoryEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CategoryEndpointProtocol {
    
    static func getCategories() -> Observable<JSON?>
}

struct CategoryEndpoint {
    
    enum Router {
        static let getCategories = "/categories"
    }
}

extension CategoryEndpoint : CategoryEndpointProtocol {
    
    static func getCategories() -> Observable<JSON?> {
        let url = Router.getCategories
        
        return APIHelper.request(.get, url)
    }
}
