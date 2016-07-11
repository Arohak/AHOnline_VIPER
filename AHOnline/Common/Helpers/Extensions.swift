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
}

extension NSDate {
    var miliseconds: String {
        return "\(Int64(self.timeIntervalSince1970*1000))"
    }
}