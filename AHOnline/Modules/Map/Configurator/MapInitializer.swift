//
//  MapInitializer.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MapModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = MapModuleConfigurator()
        configurator.configureModuleForController(viewController)
    }
}
