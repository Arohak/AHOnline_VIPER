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
        return DBManager.getUser()
    }
    
    var storedProducts: Results<Product> {
        return DBManager.getProducts()
    }
}

//MARK: - extension for ProductInteractorInput -
extension ProductInteractor: ProductInteractorInput {
    
    func getProducts(requestType: RequestType, json: JSON) {
        var js = json
        if let  user = user { js["user_id"].stringValue = "\(user.id)" }
        
        _ = APIManager.getProducts(requestType: requestType, json: js)
            .subscribe(onNext: { result in
                if result != nil {
                    var products: [Product] = []
                    for item in result["data"].arrayValue {
                        let product = Product(data: item)
                        
                        let findStoredProduct = self.storedProducts.filter { $0.id == product.id }.first
                        if let findStoredProduct = findStoredProduct {
                            products.append(findStoredProduct)
                        } else {
                            products.append(product)
                        }
                    }
                    self.output.productsDataIsReady(products: products)
                }
                }, onError: { error in
                    switch requestType {
                    case .FAVORITE:
                        let products = DBManager.getProductsLimitOffset(offset: json["offset"].intValue, limit: json["limit"].intValue)
                        self.output.productsDataIsReady(products: Array(products))
                    default:
                        break
                    }
            })
    }
    
    func addProductBuy(product: Product) {
        if product.countBuy < CA_COUNT - 1 {
            DBManager.addProduct(product: product)
            output.addProductIsReady(product: product)
        } else {
            UIHelper.showHUD(message: "max_message".localizedString)
        }
    }
    
    func updateFavoriteProduct(product: Product) {
        if let  user = user {
            _ = APIManager.updateFavoriteProduct(user_id: "\(user.id)", product_id: "\(product.id)")
                .subscribe(onNext: { result in
                    if result != nil {
                        DBManager.updateFavoriteProduct(product: product)
                        
                        self.output.updateProductIsReady(product: product)
                    }
                })
        }
    }
}
