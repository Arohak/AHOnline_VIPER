//
//  UIDevice.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import Foundation
import UIKit

enum Device {
    static let model                    = UIDevice.current.model
    static let systemVersion            = UIDevice.current.systemVersion
    static let identifier               = UIDevice.current.identifierForVendor
    static let iphone                   = UIDevice.current.userInterfaceIdiom == .phone && Screen.max_length < 568.0
    static let iphone_5                 = UIDevice.current.userInterfaceIdiom == .phone && Screen.max_length == 568.0
    static let iphone_6                 = UIDevice.current.userInterfaceIdiom == .phone && Screen.max_length == 667.0
    static let iphone_6p                = UIDevice.current.userInterfaceIdiom == .phone && Screen.max_length == 736.0
    static let ipad                     = UIDevice.current.userInterfaceIdiom == .pad
}

enum Screen {
    static let width                    = UIScreen.main.bounds.size.width
    static let height                   = UIScreen.main.bounds.size.height
    static let max_length               = max(Screen.width, Screen.height)
    static let min_length               = min(Screen.width, Screen.height)
}

enum Scale {
    static let iphone_5 : CGFloat       = 568 / 736
    static let iphone_6 : CGFloat       = 667 / 736
    static let iphone_6p : CGFloat      = 736 / 736
    static let ipad : CGFloat           = 1024 / 736
}

public extension UIDevice {
    
    enum type {
        case Simulator, iPhone_4, iPhone_5, iPhone_6, iPhone_6p, iPhone_7, iPhone_7p, iPad, NON
    }
    
    class var modelType: type {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .iPad
            
        } else {
            switch Screen.max_length {
            case 568.0:
                return .iPhone_5
            case 667.0:
                return .iPhone_6
            case 736.0:
                return .iPhone_6p
            default:
                return .NON
            }
        }
    }

    class var realModelType: type {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone7,1":
            return .Simulator
        case "iPhone3,1", "iPhone3,2", "iPhone3,3", "iPhone4,1":
            return .iPhone_4
        case "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2":
            return .iPhone_5
        case "iPhone7,2", "iPhone8,1":
            return .iPhone_6
        case "iPhone7,1":
            return .iPhone_6p
        case "iPhone9,1", "iPhone9,3":
            return .iPhone_7
        case "iPhone9,2", "iPhone9,4":
            return .iPhone_7p
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad3,1", "iPad3,2", "iPad3,3", "iPad3,4", "iPad3,5", "iPad3,6", "iPad 4", "iPad4,1", "iPad4,2", "iPad4,3", "iPad Air", "iPad5,3", "iPad5,4", "iPad Air 2", "iPad2,5", "iPad2,6", "iPad2,7", "iPad Mini", "iPad4,4", "iPad4,5", "iPad4,6", "iPad Mini 2", "iPad4,7", "iPad4,8", "iPad4,9", "iPad Mini 3", "iPad5,1", "iPad5,2", "iPad Mini 4", "iPad6,7", "iPad6,8", "iPad Pro" :
            return .iPad
        case "i386", "x86_64":
            return .Simulator
        default:
            return .NON
        }
    }
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":
            return "iPod Touch 5"
        case "iPod7,1":
            return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            return "iPhone 4"
        case "iPhone4,1":
            return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":
            return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":
            return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":
            return "iPhone 5s"
        case "iPhone7,2":
            return "iPhone 6"
        case "iPhone7,1":
            return "iPhone 6 Plus"
        case "iPhone8,1":
            return "iPhone 6s"
        case "iPhone9,1", "iPhone9,3":
            return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":
            return "iPhone 7 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
            return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":
            return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":
            return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":
            return "iPad Air"
        case "iPad5,3", "iPad5,4":
            return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":
            return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":
            return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":
            return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":
            return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":
            return "iPad Pro"
        case "AppleTV5,3":
            return "Apple TV"
        case "i386", "x86_64":
            return "Simulator"
        default:
            return identifier
        }
    }
}
