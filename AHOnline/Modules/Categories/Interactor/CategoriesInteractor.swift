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
    
    var categories: [Category] = []
    
    func testCategories() {
        categories = [Category(data: JSON(["name" : "Restaurant", "sub_categories" : []])),
                      Category(data: JSON(["name" : "Shop", "sub_categories" : []])),
                      Category(data: JSON(["name" : "Flower", "sub_categories" : []]))]
    }
}

//MARK: - extension for CategoriesInteractorInput -
extension CategoriesInteractor: CategoriesInteractorInput {
    
    func getCategories() {
        testCategories()
        output.categoriesDataIsReady(categories)
        
//        _ = APIManager.getCategories()
//            .subscribe(onNext: { result in
//                if result != nil {
//                    for item in result["data"].arrayValue {
//                       self.categories.append(Category(data: item))
//                    }
//                    
//                    self.output.categoriesDataIsReady(self.categories)
//                }
//            })
    }
}