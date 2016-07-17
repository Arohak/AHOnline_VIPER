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
    var selectedObjectCategory: ObjectCategory!
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
    
    func getObjectCategories(object: AHObject) {
        selectedObject = object
        
        let json = JSON([
            "object_id"         : selectedObject.id])
        
        _ = APIManager.getObjectCategories(json)
            .subscribe(onNext: { result in
                if result != nil {
                    var objectCategories: [ObjectCategory] = []
                    for item in result["data"].arrayValue {
                        objectCategories.append(ObjectCategory(data: item))
                    }
                    
                    self.output.objectCategoriesDataIsReady(self.selectedObject, objectCategories: objectCategories)
                }
            })
    }
    
    func getProducts(objectCategory: ObjectCategory) {
        selectedObjectCategory = objectCategory
        
        let json = JSON([
            "categoryitem_id"   : selectedObjectCategory.id])
        
        _ = APIManager.getProducts(json)
            .subscribe(onNext: { result in
                if result != nil {
                    var products: [Product] = []
                    for item in result["data"].arrayValue {
                        let product = Product(data: item)
                        let findProduct = DBManager.getOrders().filter { $0.id == product.id }.first
                        if let findProduct = findProduct {
                            products.append(findProduct)
                        } else {
                            products.append(product)

                        }
                    }
                    
                    self.output.productsDataIsReady(products)
                }
            })
    }
}