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
}

//MARK: - extension for CategoriesInteractorInput -
extension CategoriesInteractor: CategoriesInteractorInput {
    
    func getCategories() {
        _ = APIManager.getCategories()
            .subscribe(onNext: { result in
                if result != nil {
                    for item in result["data"].arrayValue {
                       self.categories.append(Category(data: item))
                    }
                    
                    self.output.categoriesDataIsReady(self.categories)
                }
            })
    }
    
    func getObjects(json: JSON) {
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