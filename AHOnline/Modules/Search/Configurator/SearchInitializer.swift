//
//  SearchInitializer.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class SearchModuleInitializer {

    init(viewController: AnyObject) {
        let configurator = SearchModuleConfigurator()
        configurator.configureModuleForController(viewController)
    }
}
