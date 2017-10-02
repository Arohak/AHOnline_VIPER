//
//  MainEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol MainEndpointProtocol {
    
    static func getFeeds(_ showProgress: Bool) -> Observable<JSON?>
}

struct MainEndpoint {

    enum Router {
        static let feeds = "/home"
    }
}

extension MainEndpoint : MainEndpointProtocol {
    
    static func getFeeds(_ showProgress: Bool) -> Observable<JSON?> {
        let url = Router.feeds
        
        return APIHelper.request(.get, url, nil, showProgress)
    }
}
