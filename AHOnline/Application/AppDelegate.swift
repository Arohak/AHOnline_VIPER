//
//  AppDelegate.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        startApplication()
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let characterSet = NSCharacterSet(charactersInString: "<>")
        let token = deviceToken.description.stringByTrimmingCharactersInSet(characterSet).stringByReplacingOccurrencesOfString(" ", withString: "")
        
        Preferences.savePushNotificationToken(token)
    }
    
    // MARK: - Private Method -
    private func startApplication() {
        UIHelper.configurateApplicationApperance()
        initApplicationNotificationSettings()
        initServices()
        
        Wireframe.start()
    }
    
    private func initApplicationNotificationSettings() {
        let settings = UIUserNotificationSettings(forTypes: [.Badge, .Alert, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    private func initServices() {
//        Fabric.with([Crashlytics.self])
        GMSServices.provideAPIKey("AIzaSyC0ZOSD0RDLsrraE7iID3jQDSG0j-L35rU")
    }
}

