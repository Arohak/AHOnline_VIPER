//
//  Result.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class StringObject: Object {
    dynamic var value = ""
}

class Result: Object {
    
    dynamic var status: String!
    dynamic var message: String!
    
    override static func primaryKey() -> String {
        return "status"
    }
    
    convenience init(data: JSON) {
        self.init()
        
        self.status     = data["status"].stringValue
        self.message    = data["message"].stringValue
    }
}