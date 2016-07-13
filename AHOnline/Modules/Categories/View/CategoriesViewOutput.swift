//
//  CategoriesViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CategoriesViewOutput {

    func viewIsReady()
    func didSelectCategory(category: Category)
    func didSelectSubcategoryRow(subcategory: Subcategory)
    func didSelectObjectRow(object: AHObject)
}
