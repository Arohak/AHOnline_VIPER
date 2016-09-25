//
//  HomeInitializer.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HomeModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = HomeModuleConfigurator()
        configurator.configureModuleForController(viewInput: viewController)
    }
}
