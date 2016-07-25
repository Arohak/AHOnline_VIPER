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

    func getProducts(json: JSON) {
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
    
    func addProductBuy(product: Product) {
        DBManager.addProduct(product)
    }
}