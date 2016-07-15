//
//  ProductInteractorswift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ProductInteractor -
class ProductInteractor {

    weak var output: ProductInteractorOutput!
}

//MARK: - extension for ProductInteractorInput -
extension ProductInteractor: ProductInteractorInput {

    func addProductBuy(product: Product) {
        DBManager.addProduct(product)
    }
}