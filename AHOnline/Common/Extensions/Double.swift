//
//  Double.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import Foundation

extension Double {
    
    var round: String {
        let number = Int(self)
        return "\(number)"
    }
    
    var format: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
//        formatter.maximumFractionDigits = 1
//        formatter.minimumFractionDigits = 1
//        formatter.paddingPosition = .BeforePrefix
//        formatter.paddingCharacter = "0"
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        let num = formatter.number(from: "\(self)")
        
        return num == nil ? "" : formatter.string(from: num!)!
    }
}
