//
//  Config.swift
//
/*******************************************************************************
 * IMUSIC LLC. CONFIDENTIAL AND PROPRIETARY
 * FOR USE BY AUTHORIZED PERSONS ONLY
 *
 * This is an unpublished work fully protected by the
 * Armenian copyright laws and is a trade secret
 * belonging to the copyright holder.
 *
 * Copyright (c) 2017 imusic LLC.
 * All Rights Reserved.
 *******************************************************************************/

import SwiftyJSON
import UIKit

struct Config {
    
    static let filename     = "Config"
    static let api          = "api"
    static let realm        = "realm"
    static let firebase     = "firebase"
    static let hockeyapp    = "hockeyapp"
    static let google       = "google"

    static func loadPlist() -> Dictionary<String, AnyObject>? {
        if let path = Bundle.main.path(forResource: filename, ofType: "plist") {
            return NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject>
        }
        
        return nil
    }
    
    static func getChild(_ name: String) -> Dictionary<String, String>? {
        if let dictionary = loadPlist(), let value = dictionary[name] as? Dictionary<String, String> {
            return value
        }
        
        return nil
    }
    
    //MARK: - API -
    static func getApiBaseUrl() -> String {
        if let dictionary = getChild(api), let value = dictionary["url"] {
            return value
        }
        
        return ""
    }
    
    static func getApiKey() -> String {
        if let dictionary = getChild(api), let value = dictionary["key"] {
            return value
        }
        
        return ""
    }
    
    //MARK: - Realm -
    static func getRealmSchemaVersion() -> UInt64 {
        if let dictionary = getChild(realm), let value = dictionary["version"], let version = UInt64(value) {                return version
        }
        
        return 0
    }
    
    static func getBundleVersionNumber() -> UInt64 {
        if let version = Bundle.main.buildVersion {
            let array = version.components(separatedBy: ".")
            let value = array.joined(separator: "")
            if let number = UInt64(value) {
                return number
            }
        }
        
        return 0
    }
    
    //MARK: - Firebase -
    static func getFirebaseEmail() -> String {
        if let dictionary = getChild(firebase), let value = dictionary["email"] {
            return value
        }
        
        return ""
    }
    
    static func getFirebasePassword() -> String {
        if let dictionary = getChild(firebase), let value = dictionary["password"] {
            return value
        }
        
        return ""
    }
    
    static func getFirebaseRadio() -> String {
        if let dictionary = getChild(firebase), let value = dictionary["radio"] {
            return value
        }
        
        return ""
    }
    
    //MARK: - HockeyApp -
    static func getHockeyAppIdentifier() -> String {
        if let dictionary = getChild(hockeyapp), let value = dictionary["identifier"] {
            return value
        }
        
        return ""
    }

    //MARK: - Google -
    static func getGoogleMapKey() -> String {
        if let dictionary = getChild(google), let value = dictionary["map_key"] {
            return value
        }
        
        return ""
    }
    
    static func getGAITrackingId() -> String {
        if let dictionary = getChild(google), let value = dictionary["analytics_id"] {
            return value
        }
        
        return ""
    }
}
