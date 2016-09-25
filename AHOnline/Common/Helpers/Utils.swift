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
            let interval: TimeInterval = time/1000
            let date = Date(timeIntervalSince1970: interval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd.yyyy '|' HH:mm"
            str = dateFormatter.string(from: date)
        }

        return str
    }
    
    static func stringFromDateTimeEU(dateString: String) -> String {
        var str = ""
        if let time = Double(dateString) {
            let interval: TimeInterval = time/1000
            let date = Date(timeIntervalSince1970: interval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy '|' HH:mm"
            str = dateFormatter.string(from: date)
        }
        
        return str
    }
    
    static func stringFromDateTimeMin(dateString: String) -> String {
        var str = ""
        if let time = Double(dateString) {
            let interval: TimeInterval = time/1000
            let date = Date(timeIntervalSince1970: interval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            str = dateFormatter.string(from: date)
        }
        
        return str
    }
    
    static func stringFromDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString as String)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    static func stringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: date as Date)
    }
    
    static func stringFromDateMin(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM.dd.yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    static func formateString(number: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.paddingPosition = .beforePrefix
        formatter.paddingCharacter = "0"
        formatter.numberStyle = .decimal
        let num = formatter.number(from: number)

        return num == nil ? "" : formatter.string(from: num!)!
    }
    
    static func maskImage(image: UIImage, withMask maskImage: UIImage) -> UIImage {
        let newSize = CGSize(width: image.size.width, height: image.size.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        maskImage.draw(in: MP_PIN_CIRCLE_RECT, blendMode: .normal, alpha: 1.0)
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return maskedImage
    }
    
    static func localizedLanguage(key: String, languageCode: String) -> String {
        var path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        path = path != nil ? path : ""
        let languageBundle: Bundle!
        if (FileManager.default.fileExists(atPath: path!)) {
            languageBundle = Bundle(path: path!)
            return languageBundle!.localizedString(forKey: key, value: "", table: nil)
        } else{
            languageBundle = Bundle.main
            return languageBundle!.localizedString(forKey: key, value: "", table: nil)
        }
    }
    
    static func isOnlyNumber(text: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"123456789").inverted
        let components = text.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        return text == filtered && Int(text)! < 21
    }
}

