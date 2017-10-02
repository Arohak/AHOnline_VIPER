//
//  UserEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol UserEndpointProtocol {
    
    static func createUser() -> Observable<JSON?>
    static func getUser(_ id: String) -> Observable<JSON?>
    static func sendPhone(_ id: String, number: String) -> Observable<JSON?>
    static func verifyPhone(_ pin: String) -> Observable<JSON?>
}

struct UserEndpoint {
    
    enum Router {
        static let createUser   = "/users"
        static let getUser      = "/users/%@"
        static let sendPhone    = "/send_phone"
        static let verifyPhone  = "/verify"
    }
}

extension UserEndpoint : UserEndpointProtocol {

    static func createUser() -> Observable<JSON?> {
        let url = Router.createUser
        
        return APIHelper.request(.post, url)
    }
    
    static func getUser(_ id: String) -> Observable<JSON?> {
        let url = String(format: Router.getUser, id)

        return APIHelper.request(.get, url)
    }
    
    static func sendPhone(_ id: String, number: String) -> Observable<JSON?> {
        let url = Router.sendPhone
        let params = [
            "id" :              id,
            "mobile_number" :   number
        ]

        return APIHelper.request(.post, url, params)
    }
    
    static func verifyPhone(_ pin: String) -> Observable<JSON?> {
        let url = Router.verifyPhone
        let params = [
            "verification_code" : pin
        ]

        return APIHelper.request(.post, url, params)
    }
}
