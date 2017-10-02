//
//  FavoriteEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol FavoriteEndpointProtocol {
    
    static func updateFavorite(userId: String, productId: String) -> Observable<JSON?>
}

struct FavoriteEndpoint {
    
    enum Router {
        static let updateFavorite    = "/favorites/%@"
    }
}

extension FavoriteEndpoint : FavoriteEndpointProtocol {

    static func updateFavorite(userId: String, productId: String) -> Observable<JSON?> {
        let url = String(format: Router.updateFavorite, productId)
        let params = [ "user_id" : userId ]
        
        return APIHelper.request(.put, url, params)
    }
}
