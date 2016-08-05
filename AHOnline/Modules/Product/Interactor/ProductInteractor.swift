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
    
    var user: User! {
        return DBManager.getUser()
    }
    
    var orderProducts: Results<Product> {
        return DBManager.getOrders()
    }
    
    var storedProducts: Results<Product> {
        return DBManager.getProducts()
    }
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
                        let findOrderProduct = self.orderProducts.filter { $0.id == product.id }.first
                        let findFavoriteProduct = self.storedProducts.filter { $0.id == product.id }.first

//                        if let findOrderProduct = findOrderProduct {
//                            products.append(findOrderProduct)
//                        } else if let findFavoriteProduct = findFavoriteProduct {
//                            products.append(product)
//                        }
                    }
                    
                    self.output.productsDataIsReady(products, storedProducts: self.storedProducts)
                }
            })
    }
    
    func addProductBuy(product: Product) {
        DBManager.addProduct(product)
    }
    
    func updateFavoriteProduct(product: Product) {
        _ = APIManager.updateFavoriteProduct("\(user.id)", product_id: "\(product.id)")
        .subscribeNext({ result in
            if result != nil {
                DBManager.updateFavoriteProduct(product)
            }
        })
    }
}