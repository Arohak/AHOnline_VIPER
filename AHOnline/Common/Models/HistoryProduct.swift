//
//  HistoryProduct.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HistoryProduct: Object {
    
    dynamic var id = 0
    dynamic var countBuy = 0
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.id         = data["id"].intValue
        self.countBuy   = data["count_buy"].intValue
    }
}