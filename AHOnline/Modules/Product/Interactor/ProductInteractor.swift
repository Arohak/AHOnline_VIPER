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
    
    var storedProducts: Results<Product> {
        return DBManager.getProducts()
    }
}

//MARK: - extension for ProductInteractorInput -
extension ProductInteractor: ProductInteractorInput {
    
    func getProducts(requestType: RequestType, json: JSON) {
        var js = json
        js["user_id"].stringValue = "\(user.id)"
        
        _ = APIManager.getProducts(requestType, json: js)
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
                    self.output.productsDataIsReady(products)
                }
                }, onError: { error in
                    switch requestType {
                    case .FAVORITE:
                        let products = DBManager.getProductsLimitOffset(json["offset"].intValue, limit: json["limit"].intValue)
                        self.output.productsDataIsReady(Array(products))
                    default:
                        break
                    }
            })
    }
    
    func addProductBuy(product: Product) {
        if product.countBuy < CA_COUNT - 1 {
            DBManager.addProduct(product)
            output.addProductIsReady(product)
        } else {
            UIHelper.showHUD("max_message".localizedString)
        }
    }
    
    func updateFavoriteProduct(product: Product) {
        _ = APIManager.updateFavoriteProduct("\(user.id)", product_id: "\(product.id)")
        .subscribeNext({ result in
            if result != nil {
                DBManager.updateFavoriteProduct(product)
                
                self.output.updateProductIsReady(product)
            }
        })
    }
}