//
//  CategoriesInteractor.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CategoriesInteractor -
class CategoriesInteractor {

    weak var output: CategoriesInteractorOutput!
    
    var selectedCategory: Category!
    var selectedSubcategory: Subcategory!
    var selectedObject: AHObject!
    var selectedObjectMenu: ObjectMenu!
}

//MARK: - extension for CategoriesInteractorInput -
extension CategoriesInteractor: CategoriesInteractorInput {
    
    func getCategories() {
        _ = APIManager.getCategories()
            .subscribe(onNext: { result in
                if result != nil {
                    var categories: [Category] = []
                    for item in result["data"].arrayValue {
                       categories.append(Category(data: item))
                    }
                    
                    self.output.categoriesDataIsReady(categories)
                }
            })
    }
    
    func selectCategory(category: Category) {
        selectedCategory = category
    }
    
    func getObjects(subcategory: Subcategory) {
        selectedSubcategory = subcategory
        
        let json = JSON([
            "category_id"       : selectedCategory.id,
            "subcategory_id"    : selectedSubcategory.id])
        
        _ = APIManager.getObjects(json)
            .subscribe(onNext: { result in
                if result != nil {
                    var objects: [AHObject] = []
                    for item in result["data"]["restaurants"].arrayValue {
                        objects.append(AHObject(data: item))
                    }
                    
                    self.output.objectsDataIsReady(objects)
                }
            })
    }
}