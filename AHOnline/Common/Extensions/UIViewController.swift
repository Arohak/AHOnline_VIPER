//
//  ViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

extension UIViewController {
    
    func setScreenName(name: String) {
        self.title = name
        self.sendScreenView()
    }
    
    func sendScreenView() {
        weak var tracker = GAI.sharedInstance().defaultTracker
        tracker!.set(kGAIScreenName, value: self.title)
        tracker!.send(GAIDictionaryBuilder.createScreenView()?.build() as [NSObject : AnyObject]!)
    }
    
    func trackEvent(category: String, action: String, label: String, value: NSNumber?) {
        let tracker = GAI.sharedInstance().defaultTracker
        let trackDictionary = GAIDictionaryBuilder.createEvent(withCategory: category, action: action, label: label, value: value)
        tracker?.send(trackDictionary?.build() as [NSObject : AnyObject]!)
    }
}
