//
//  ObjectInteractor.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ObjectInteractor -
class ObjectInteractor {

    weak var output: ObjectInteractorOutput!
}

//MARK: - extension for ObjectInteractorInput -
extension ObjectInteractor: ObjectInteractorInput {
    
    func getProducts(objectMenu: ObjectMenu) {
        _ = APIManager.getProducts("\(objectMenu.id)")
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