//
//  CategoriesInteractorInput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol CategoriesInteractorInput {

    func getCategories()
    func selectCategory(category: Category)
    func getObjects(subcategory: Subcategory)
    func getObjectCategories(object: AHObject)
}
