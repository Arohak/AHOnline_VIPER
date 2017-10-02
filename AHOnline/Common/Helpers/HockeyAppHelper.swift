//
//  HockeyAppHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import HockeySDK

struct HockeyAppHelper {

    static let identifier = Config.getHockeyAppIdentifier()

    static func configurate() {
        BITHockeyManager.shared().configure(withIdentifier: identifier)
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation()
    }
}
