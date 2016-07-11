//
//  CartInitializer.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class CartModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = CartModuleConfigurator()
        configurator.configureModuleForController(viewController)
    }
}
