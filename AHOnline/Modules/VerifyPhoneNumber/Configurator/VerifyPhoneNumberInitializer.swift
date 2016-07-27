//
//  VerifyPhoneNumberInitializer.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class VerifyPhoneNumberModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = VerifyPhoneNumberModuleConfigurator()
        configurator.configureModuleForController(viewController)
    }
}
