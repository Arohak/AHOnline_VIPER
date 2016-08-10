//
//  HistoryOrder.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HistoryOrder: Object {
    
    dynamic var title: String!
    dynamic var dateCreate: String!
    dynamic var mobileNumber: String!
    dynamic var deliveryAddress: String!
    dynamic var deliveryCity: String!
    dynamic var deliveryAlias: String!
    dynamic var deliveryDate: String!
    dynamic var payment: String!
    dynamic var ordersTotalPrice = 0.0
    dynamic var deliveryPrice = 0.0
    dynamic var totalPrice = 0.0

    var historyProducts = List<HistoryProduct>()
    

    override static func primaryKey() -> String {
        return "dateCreate"
    }
    
    convenience init(data: JSON) {
        self.init()

        self.title              = data["title"].stringValue
        self.dateCreate         = data["date_create"].stringValue
        self.mobileNumber       = data["mobile_number"].stringValue
        self.deliveryAddress    = data["delivery_address"].stringValue
        self.deliveryCity       = data["delivery_city"].stringValue
        self.deliveryAlias      = data["delivery_alias"].stringValue
        self.deliveryDate       = data["delivery_date"].stringValue
        self.payment            = data["payment"].stringValue
        self.ordersTotalPrice   = data["orders_total_price"].doubleValue
        self.deliveryPrice      = data["delivery_price"].doubleValue
        self.totalPrice         = data["total_price"].doubleValue
    }
    
    func addHistoryProductFrom(products: List<Product>) {
        for product in products {
            let historyProduct = HistoryProduct(data: JSON([
                "id"            : product.id,
                "product_id"    : product.product_id,
                "count_buy"     : product.countBuy
                ]))
            historyProducts.append(historyProduct)
        }
    }
}