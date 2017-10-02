//
//  GoogleHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import GoogleMaps

struct GoogleHelper {

    static let mapKey       = Config.getGoogleMapKey()
    static let trackingId   = Config.getGAITrackingId()

    static func configurateMap() {
        GMSServices.provideAPIKey(mapKey)
    }
    
    static func configurateAnalytics() {
        guard let gai = GAI.sharedInstance() else { return }
        
        gai.tracker(withTrackingId: trackingId)
        gai.trackUncaughtExceptions = true
    }
}
