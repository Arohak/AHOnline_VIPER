//
//  OrderEndpoint.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol OrderEndpointProtocol {
    
    static func createOrder(_ userId: String, order: HistoryOrder) -> Observable<JSON?>
    static func getOrders(_ userId: String) -> Observable<JSON?>
}

struct OrderEndpoint {
    
    enum Router {
        static let createOrder   = "/orders"
        static let getOrder      = "/orders?user_id=%@"
    }
}

extension OrderEndpoint : OrderEndpointProtocol {

    static func createOrder(_ userId: String, order: HistoryOrder) -> Observable<JSON?> {
        let url = Router.createOrder

        var historyProducts: [Dictionary<String, Int>] = []
        for historyProduct in Array(order.historyProducts) {
            let hash = ["product_id": historyProduct.productID,
                        "count_buy": historyProduct.countBuy]
            historyProducts.append(hash)
        }
        
        let params: [String: Any] = ["user_id"             : userId,
                                     "title"               : order.title,
                                     "date_create"         : order.dateCreate,
                                     "mobile_number"       : order.mobileNumber,
                                     "delivery_address"    : order.deliveryAddress,
                                     "delivery_city"       : order.deliveryCity,
                                     "delivery_alias"      : order.deliveryAlias,
                                     "delivery_date"       : order.deliveryDate,
                                     "payment"             : order.payment,
                                     "orders_total_price"  : order.ordersTotalPrice,
                                     "delivery_price"      : order.deliveryPrice,
                                     "total_price"         : order.totalPrice,
                                     "is_verified"         : order.isVerified,
                                     "products"            : historyProducts]
        
        return APIHelper.request(.post, url, params)
    }
    
    static func getOrders(_ userId: String) -> Observable<JSON?> {
        let url = String(format: Router.getOrder, userId)
        
        return APIHelper.request(.get, url)
    }
}
