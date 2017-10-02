//
//  Preferences.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct Preferences {
    
    static private func saveToUserDefaultsWithKey(key: String, value: Any?) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    static private func readFromUserDefaults(key: String) -> Any? {
        let userDefaults = UserDefaults.standard
        if let key = userDefaults.object(forKey: key) {
            return key
        }
        
        return nil
    }
    
    //MARK: - RESET -
    static func resetStandardUserDefaults() {
        let firstRun = self.appFirstRun()
        let email = self.getEmail()
        let language = self.getAppLanguage()

        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        
        self.setAppFirstRun(value: firstRun)
        if let email = email { self.saveEmail(value: email) }
        self.saveAppLanguage(lng: language)
    }
    
    //MARK: - SETTERS -
    static func saveAppLanguage(lng: String) {
        self.saveToUserDefaultsWithKey(key: "lng", value:lng)
    }
    
    static func saveToken(value: String) {
        self.saveToUserDefaultsWithKey(key: "authkey", value: value)
    }
    
    static func savePushNotificationToken(value: String) {
        self.saveToUserDefaultsWithKey(key: "push_token", value: value)
    }
    
    static func setAppFirstRun(value: Bool) {
        self.saveToUserDefaultsWithKey(key: "first_run", value: value)
    }
    
    static func saveEmail(value: String) {
        self.saveToUserDefaultsWithKey(key: "remember_email", value: value)
    }


    //MARK: - GETTERS -
    static func isAuthorized() -> Bool {
        if let _ = readFromUserDefaults(key: "authkey") {
            return true
        }
        
        return false
    }
    
    static func getAppLanguage() -> String {
        if let lng = readFromUserDefaults(key: "lng") as? String {
            return lng
        }
        
        return "en"
    }
    
    static func getToken() -> String? {
        return self.readFromUserDefaults(key: "authkey") as? String
    }
    
    static func getPushNotificationToken() -> String? {
        return self.readFromUserDefaults(key: "push_token") as? String
    }
    
    static func appFirstRun() -> Bool {
        let value = readFromUserDefaults(key: "first_run") as? Bool
        
        return value == nil ? false : true
    }
    
    static func getEmail() -> String? {
        return self.readFromUserDefaults(key: "remember_email") as? String
    }
}

