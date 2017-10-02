//
//  AppDelegate.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import UserNotifications
import FacebookCore
import PushKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //fb
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        startApplication()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return SDKApplicationDelegate.shared.application(application, open: url)
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        return SDKApplicationDelegate.shared.application(application, open: url, options: options)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        AppEventsLogger.activate(application)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let characterSet = CharacterSet(charactersIn: "<>")
        let token = deviceToken.description.trimmingCharacters(in: characterSet).replacingOccurrences(of: " ", with: "")
        
        Preferences.savePushNotificationToken(value: token)
    }
}

    //MARK: - Private Methods -
extension AppDelegate {

    fileprivate func startApplication() {
        
        // start listening network
        APIHelper.startListeningNetwork()
        
        // configurate application apperance
        UIHelper.configurateApplicationApperance()
        
        // update realm schema version
        DBHelper.updateRealmSchemaVersion()
        
        // configurate google analitics
        GoogleHelper.configurateAnalytics()
        
        // configurate google map
        GoogleHelper.configurateMap()
        
        // use hockeyapp for crash report
        HockeyAppHelper.configurate()
        
        // use firebase for observe radios
        FirebaseHelper.configurate()

        // config root view controller
        Wireframe.start()
    }
    
    private func registerRemoteNotifications() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in }
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        }
    }
}
