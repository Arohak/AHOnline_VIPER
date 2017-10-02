//
//  Date.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 31/08/2017.
//  Copyright © 2017 AroHak LLC. All rights reserved.
//

import Foundation

extension Date {
    
    var miliseconds: String {
        return "\(Int64(self.timeIntervalSince1970*1000))"
    }
    
    var deliveryTimeFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateFormat = "MMM d 'at' HH:mm" //"YYYY-MM-DD HH:00", "MMM d 'at' HH:m"
        
        return dateFormatter.string(from: self)
    }
    
    var createTimeFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateFormat = "d MMM yyyy 'at' HH:mm:ss"
        
        return dateFormatter.string(from: self)
    }
}
