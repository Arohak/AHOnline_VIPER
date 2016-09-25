//
//  Extensions.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - String -
extension String {
    
    var localizedString: String {
        return Utils.localizedLanguage(key: self, languageCode: Preferences.getAppLanguage())
    }
    
    var date: NSDate? {
        var date: NSDate?
        let value =  Double(self)
        if let value = value {
            let interval: TimeInterval = value/1000
            date = NSDate(timeIntervalSince1970: interval)
        }
        return date
    }
    
    var shortTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
   
    var dram: String {
        return  self + " \u{058F}"
    }
}

//MARK: - NSDate -
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

//MARK: - Double -
extension Double {
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
