//
//  Utils.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct Utils {
    
    static func stringFromDateTime(dateString: String) -> String {
        var str = ""
        if let time = Double(dateString) {
            let interval: NSTimeInterval = time/1000
            let date = NSDate(timeIntervalSince1970: interval)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM.dd.yyyy '|' HH:mm"
            str = dateFormatter.stringFromDate(date)
        }

        return str
    }
    
    static func stringFromDateTimeEU(dateString: String) -> String {
        var str = ""
        if let time = Double(dateString) {
            let interval: NSTimeInterval = time/1000
            let date = NSDate(timeIntervalSince1970: interval)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy '|' HH:mm"
            str = dateFormatter.stringFromDate(date)
        }
        
        return str
    }
    
    static func stringFromDateTimeMin(dateString: String) -> String {
        var str = ""
        if let time = Double(dateString) {
            let interval: NSTimeInterval = time/1000
            let date = NSDate(timeIntervalSince1970: interval)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            str = dateFormatter.stringFromDate(date)
        }
        
        return str
    }
    
    static func stringFromDateString(dateString: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.defaultTimeZone()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(dateString as String)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = date {
            return dateFormatter.stringFromDate(date)
        } else {
            return ""
        }
    }
    
    static func stringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.defaultTimeZone()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.stringFromDate(date)
    }
    
    static func stringFromDateMin(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.defaultTimeZone()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM.dd.yyyy"
        
        return dateFormatter.stringFromDate(date)
    }
    
    static func formateString(number: String) -> String {
        let formatter = NSNumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.paddingPosition = NSNumberFormatterPadPosition.BeforePrefix
        formatter.paddingCharacter = "0"
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let num = formatter.numberFromString(number)

        return num == nil ? "" : formatter.stringFromNumber(num!)!
    }
    
    static func localizedLanguage(key: String, languageCode: String) -> String {
        var path = NSBundle.mainBundle().pathForResource(languageCode, ofType: "lproj")
        path = path != nil ? path : ""
        let languageBundle: NSBundle!
        if (NSFileManager.defaultManager().fileExistsAtPath(path!)) {
            languageBundle = NSBundle(path: path!)
            return languageBundle!.localizedStringForKey(key, value: "", table: nil)
        } else{
            languageBundle = NSBundle.mainBundle()
            return languageBundle!.localizedStringForKey(key, value: "", table: nil)
        }
    }
    
    static func isOnlyNumber(text: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersInString:"123456789").invertedSet
        let components = text.componentsSeparatedByCharactersInSet(inverseSet)
        let filtered = components.joinWithSeparator("")
        
        return text == filtered && Int(text) < 21
    }
}

