//
//  Extensions.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

extension String {
    var localizedString: String {
        return Utils.localizedLanguage(self, languageCode: Preferences.getAppLanguage())
    }
    
    var date: NSDate? {
        var date: NSDate?
        let value =  Double(self)
        if let value = value {
            let interval: NSTimeInterval = value/1000
            date = NSDate(timeIntervalSince1970: interval)
        }
        return date
    }
    
    var shortTime: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.defaultTimeZone()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(self)
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = date {
            return dateFormatter.stringFromDate(date)
        } else {
            return ""
        }
    }
    
}

extension NSDate {
    var miliseconds: String {
        return "\(Int64(self.timeIntervalSince1970*1000))"
    }
}

extension Double {
    var format: String {
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
//        formatter.maximumFractionDigits = 1
//        formatter.minimumFractionDigits = 1
//        formatter.paddingPosition = .BeforePrefix
//        formatter.paddingCharacter = "0"
        formatter.numberStyle = .DecimalStyle
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        let num = formatter.numberFromString("\(self)")
        
        return num == nil ? "" : formatter.stringFromNumber(num!)!
    }
}