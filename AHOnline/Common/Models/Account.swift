//
//  Account.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

enum Status: Int {
    case Active = 1
    case Deactive = 4
}

class Account: Object {
    
    dynamic var id = 0
    dynamic var virtualCardID = 0
    dynamic var number: String!
    dynamic var type: String!
    dynamic var currency: String!
    dynamic var defaultAccount = false
    dynamic var merchantAccount = false
    
    dynamic var status: String!
    dynamic var statusInt: String! {
        get {
            switch status {
            case "ACTIVE":
                return "4"
            default:
                return "1"
            }
        }
    }
    
    dynamic var title: String!
    dynamic var fullTitle: String! {
        get {
            var accountPrefix = ""
            if defaultAccount {
                accountPrefix = "default".localizedString
            }
            if !isActive {
                accountPrefix = "deactive".localizedString
            }
            let title = accountPrefix + self.title
            
            return title
        }
    }
    
    dynamic var isActive: Bool {
        let state = self.status == "ACTIVE" ? true : false
        return state
    }
    
    dynamic var isDefaultCurrency: Bool {
        let state = self.currency == "AMD" ? true : false
        return state
    }

    override static func primaryKey() -> String {
        return "id"
    }

    convenience init(data: JSON) {
        self.init()

        self.id                     = data["id"].intValue
        self.virtualCardID          = data["virtualCardID"].intValue
        self.status                 = data["status"].stringValue
        self.number                 = data["number"].stringValue
        self.type                   = data["type"].stringValue
        self.currency               = data["currency"].stringValue
        self.defaultAccount         = data["defaultAccount"].boolValue
        self.merchantAccount        = data["merchantAccount"].boolValue        
        self.title                  = data["title"].stringValue
    }
}