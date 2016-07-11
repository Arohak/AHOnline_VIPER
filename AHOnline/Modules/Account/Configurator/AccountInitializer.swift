//
//  AccountInitializer.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class AccountModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = AccountModuleConfigurator()
        configurator.configureModuleForController(viewController)
    }
}
