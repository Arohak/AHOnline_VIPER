//
//  String.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import Foundation

extension String {
    
    var localizedString: String {
        return Utils.localizedLanguage(key: self, languageCode: Preferences.getAppLanguage())
    }
    
    var timeString: String {
        if let interval = Double(self) {
            let seconds = Int(interval) % 60
            let minutes = (Int(interval) / 60) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
        return ""
    }
    
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date!)
    }

    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: date!)
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
