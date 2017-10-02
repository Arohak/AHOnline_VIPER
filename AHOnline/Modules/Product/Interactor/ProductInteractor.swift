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
    
    var user: User? {
        return DBHelper.getUser()
    }
    
    var storedProducts: Results<Product> {
        return DBHelper.getProducts()
    }
}

//MARK: - extension for ProductInteractorInput -
extension ProductInteractor: ProductInteractorInput {
    
    func getProducts(_ type: ProductsRequestType, params: JSON) {
        _ = ProductEndpoint.getProducts(type, json: params)
            .subscribe(onNext: { result in
                if let result = result {
                    var products: [Product] = []
                    for item in result["data"].arrayValue {
                        let product = Product(data: item)
                        
                        if let findStoredProduct = DBHelper.updatedProductInfo(product: product) {
                            products.append(findStoredProduct)
                        } else {
                            products.append(product)
                        }
                    }
                    self.output.productsDataIsReady(products: products)
                }
                }, onError: { error in
                    switch type {
                    case .Favorite:
                        let products = DBHelper.getProductsLimitOffset(offset: params["offset"].intValue, limit: params["limit"].intValue)
                        self.output.productsDataIsReady(products: Array(products))
                    default:
                        break
                    }
            })
    }
    
    func updateFavoriteProduct(product: Product) {
        if let  user = user {
            _ = FavoriteEndpoint.updateFavorite(userId: "\(user.id)", productId: "\(product.id)")
                .subscribe(onNext: { result in
                    if let _ = result {
                        DBHelper.updateFavoriteProduct(product: product)
                        
                        self.output.updateProductIsReady(product: product)
                    }
                })
        }
    }
    
    func addProductBuy(product: Product) {
        if product.countBuy < CA_COUNT - 1 {
            DBHelper.addProduct(product: product)
            output.addProductIsReady(product: product)
        } else {
            UIHelper.showHUD(message: "max_message".localizedString)
        }
    }
}
