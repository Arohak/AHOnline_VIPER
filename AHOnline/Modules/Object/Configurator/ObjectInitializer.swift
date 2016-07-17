//
//  ObjectInitializer.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = ObjectModuleConfigurator()
        configurator.configureModuleForController(viewController)
    }
}
