//
//  AppDelegate.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import UserNotifications

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        startApplication()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let characterSet = CharacterSet(charactersIn: "<>")
        let token = deviceToken.description.trimmingCharacters(in: characterSet).replacingOccurrences(of: " ", with: "")
        
        Preferences.savePushNotificationToken(value: token)
    }
    
    // MARK: - Private Method -
    private func startApplication() {
        UIHelper.configurateApplicationApperance()
        initApplicationNotificationSettings()
        initServices()
        
        Wireframe.start()
    }
    
    private func initApplicationNotificationSettings() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in }
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func initServices() {
//        Fabric.with([Crashlytics.self])
        GMSServices.provideAPIKey("AIzaSyC0ZOSD0RDLsrraE7iID3jQDSG0j-L35rU")
    }
}

