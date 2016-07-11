//
//  CategoriesViewInput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CategoriesViewInput: class {

    func setupInitialState(viewControllers: [UIViewController], categories: [Category])
}
