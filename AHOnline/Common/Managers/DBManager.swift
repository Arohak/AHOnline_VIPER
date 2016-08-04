//
//  DBManager.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct DBManager {
    
    private static let realm = dbHelper.realm
    
    //MARK: - User -
    static func storeUser(user: User) {
        try! realm.write {
            realm.add(user, update: true)
        }
    }
    
    static func updateUser(userInfo: UserInfo) {
        try! realm.write {
            if let user = getUser() {
                user.update(userInfo)
            }
        }
    }
    
    static func getUser() -> User? {
        let user = realm.objects(User.self).first
        
        return user
    }
    
    //MARK: - Delivery Address -
    static func storeDeliveryAddress(address: DeliveryAddress) {
        try! realm.write {
            if let user = getUser() {
                user.address = address
            }
        }
    }
    
    static func updateDeliveryAddress(info: DeliveryAddressInfo) {
        try! realm.write {
            if let address = getUser()!.address {
                address.update(info)
            }
        }
    }

    //MARK: - Product -
    static func getFavoriteProducts() -> Results<Product> {
        let products = realm.objects(Product.self).filter("favorite == true")
        return products
    }
    
    static func updateFavoriteProduct(product: Product) {
        try! realm.write {
            product.favorite = !product.favorite
        }
    }
    
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
        let findProduct = orders.filter { $0.id == product.id }.first
        if let findProduct = findProduct {
            let count = findProduct.countBuy + 1
            updateOrder(findProduct, count: count)
        } else {
            let count = product.countBuy + 1
            storeProduct(product)
            updateOrder(product, count: count)
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
    
    static func getOrdersTotalPrice() -> Double {
        var price = 0.0
        let orders = getOrders()
        for order in orders {
            price += (Double(order.countBuy) * order.price)
        }
        
        return price
    }
    
    //MARK: - Delivery -
    static func storeDeliveries(deliveries: [Delivery]) {
        try! realm.write {
            realm.add(deliveries, update: true)
        }
    }
    
    static func getDeliveries() -> Results<Delivery> {
        let deliveries = realm.objects(Delivery.self)
        return deliveries
    }
}
