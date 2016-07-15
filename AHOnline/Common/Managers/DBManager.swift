//
//  DBManager.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct DBManager {
    
    private static let realm = dbHelper.realm
    
    //MARK: - Restaurants -
    static func storeRestaurants(restaurants: [Restaurant]) {
        try! realm.write {
            realm.add(restaurants, update: true)
        }
    }
    
    //MARK: - Order -
    static func storeProducts(products: [Product]) {
        try! realm.write {
            realm.add(products, update: true)
        }
    }
    
    static func storeProduct(product: Product) {
        try! realm.write {
            realm.add(product, update: true)
            
            Wireframe.setBadgeValue(getOrderCounts())
        }
    }
    
    static func getOrders() -> Results<Product> {
        let products = realm.objects(Product.self).filter("countBuy > 0")
        return products
    }
    
    static func addProduct(product: Product) {
        let orders = getOrders()
        let findProduct = orders.filter { $0.id == product }.first
        if let product = findProduct {
            let count = product.countBuy + 1
            updateOrder(product, count: count)
        } else {
            storeProduct(product)
        }
    }
    
    static func updateOrder(product: Product, count: Int) {
        try! realm.write {
            product.countBuy = count
            
            Wireframe.setBadgeValue(getOrderCounts())
        }
    }
    
    static func removeOrder(product: Product) {
        try! realm.write {
            product.countBuy = 0
            
            Wireframe.setBadgeValue(getOrderCounts())
        }
    }
    
    static func getOrderCounts() -> Int {
        var count = 0
        let orders = getOrders()
        for order in orders {
            count += order.countBuy
        }
        
        return count
    }
}
