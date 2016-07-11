//
//  Preferences.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct Preferences {
    
    static private func saveToUserDefaultsWithKey(key: String, value: AnyObject) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(value, forKey: key)
        userDefaults.synchronize()
    }
    
    static private func readFromUserDefaults(key: String) -> AnyObject? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let key = userDefaults.objectForKey(key) {
            return key
        }
        
        return nil
    }
    
    //MARK: - RESET -
    static func resetStandardUserDefaults() {
        let firstRun = self.appFirstRun()
        let email = self.getEmail()
        let language = self.getAppLanguage()

        let appDomain = NSBundle.mainBundle().bundleIdentifier!
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
        
        self.setAppFirstRun(firstRun)
        if let email = email { self.saveEmail(email) }
        self.saveAppLanguage(language)
    }
    
    //MARK: - SETTERS -
    static func saveAppLanguage(lng: String) {
        self.saveToUserDefaultsWithKey("lng", value:lng)
    }
    
    static func saveToken(value: String) {
        self.saveToUserDefaultsWithKey("authkey", value: value)
    }
    
    static func savePushNotificationToken(value: String) {
        self.saveToUserDefaultsWithKey("pushToken", value: value)
    }
    
    static func setAppFirstRun(value: Bool) {
        self.saveToUserDefaultsWithKey("first_run", value: value)
    }
    
    static func saveEmail(value: String) {
        self.saveToUserDefaultsWithKey("remember_email", value: value)
    }


    //MARK: - GETTERS -
    static func isAuthorized() -> Bool {
        if let _ = readFromUserDefaults("authkey") {
            return true
        }
        
        return false
    }
    
    static func getAppLanguage() -> String {
        if let lng = readFromUserDefaults("lng") as? String {
            return lng
        }
        
        return "eu"
    }
    
    static func getToken() -> String? {
        return self.readFromUserDefaults("authkey") as? String
    }
    
    static func getPushNotificationToken() -> String? {
        return self.readFromUserDefaults("pushToken") as? String
    }
    
    static func appFirstRun() -> Bool {
        let value = readFromUserDefaults("first_run") as? Bool
        
        return value == nil ? false : true
    }
    
    static func getEmail() -> String? {
        return self.readFromUserDefaults("remember_email") as? String
    }
}

