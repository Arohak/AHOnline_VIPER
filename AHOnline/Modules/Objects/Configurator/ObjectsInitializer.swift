//
//  ObjectsInitializer.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectsModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = ObjectsModuleConfigurator()
        configurator.configureModuleForController(viewInput: viewController)
    }
}
