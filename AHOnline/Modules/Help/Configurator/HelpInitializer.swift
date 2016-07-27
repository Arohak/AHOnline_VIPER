//
//  HelpInitializer.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HelpModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = HelpModuleConfigurator()
        configurator.configureModuleForController(viewController)
    }
}
