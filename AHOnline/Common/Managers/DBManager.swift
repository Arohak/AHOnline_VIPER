//
//  DBManager.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

struct DBManager {
    
    static let realm = dbHelper.realm

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
        
        favoriteProduct(userInfo.favorites)
    }
    
    static func getUser() -> User? {
        let user = realm.objects(User.self).first
        
        return user
    }
    
    static func getUserCart() -> User? {
        let user = realm.objects(User.self).first
        try! realm.write {
            user?.cart.ordersTotalPrice = getOrdersTotalPrice()
            user?.cart.products.removeAll()
            for product in DBManager.getOrders() {
                user?.cart.products.append(product)
            }
        }
        
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
        if let user = getUser() {
            try! realm.write {
                if let address = user.address {
                    address.update(info)
                }
            }
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
    
    static func getProducts() -> Results<Product> {
        let products = realm.objects(Product.self)
        return products
    }
    
    static func getProductsLimitOffset(offset: Int, limit: Int) -> [Product] {
        let products = Array(realm.objects(Product.self).filter("favorite == true"))
        var temp = [Product]()
        for i in offset..<limit + offset {
            if products.count > i {
               temp.append(products[i])
            }
        }
        return temp
    }
    
    static func getFavoriteProducts() -> Results<Product> {
        let products = realm.objects(Product.self).filter("favorite == true")
        return products
    }
    
    static func updateFavoriteProduct(product: Product) {
        try! realm.write {
            let products = getFavoriteProducts()
            let findProduct = products.filter { $0.id == product.id }.first
            if let findProduct = findProduct {
                findProduct.favorite = !findProduct.favorite
            } else {
                product.favorite = true
                realm.add(product, update: true)
            }
        }
    }
    
    static func favoriteProduct(products: [Product]) {
        try! realm.write {
            let allStoredProducts = getProducts()

            for reset in allStoredProducts {
                reset.favorite = false
            }
            for product in products {
                let findFavoriteProduct = allStoredProducts.filter { $0.id == product.id }.first
                if let findProduct = findFavoriteProduct {
                    findProduct.favorite = true
                } else {
                    product.favorite = true
                    realm.add(product, update: true)
                }
            }
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
    
    static func updateCartInfo(mobileNumber: String, address: String, city: String, alias: String, deliveryPrice: Double, date: NSDate, payment: String)  {
        if let user = getUser() {
            try! realm.write {
                let cart = user.cart
                cart.mobileNumber = mobileNumber
                cart.deliveryAddress = address
                cart.deliveryCity = city
                cart.deliveryAlias = alias
                cart.deliveryPrice = deliveryPrice
                cart.deliveryDate = date
                cart.payment = payment
            }
        }
    }
    
    static func updateOrder(product: Product, count: Int) {
        if let user = getUser() {
            try! realm.write {
                product.countBuy = count
                user.cart.ordersTotalPrice = getOrdersTotalPrice()
                
                Wireframe.setBadgeValue(getOrderCounts())
            }
        }
    }
    
    static func removeOrders() {
        if let user = getUser() {
            for product in user.cart.products {
                removeOrder(product)
            }
        }
    }
    
    static func removeOrder(product: Product) {
        if let user = getUser() {
            try! realm.write {
                product.countBuy = 0
                user.cart.ordersTotalPrice = getOrdersTotalPrice()
                user.cart.products.removeAtIndex(user.cart.products.indexOf(product)!)
                
                Wireframe.setBadgeValue(getOrderCounts())
            }
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
            
            if let user = getUser() {
                user.cart.deliveries.removeAll()
                for delivery in deliveries {
                  user.cart.deliveries.append(delivery)
                }
            }
        }
    }
    
    static func getDeliveries() -> Results<Delivery> {
        let deliveries = realm.objects(Delivery.self)
        return deliveries
    }
    
    //MARK: - Order -
    static func storeHistoryOrder(historyOrder: HistoryOrder) {
        try! realm.write {
            realm.add(historyOrder, update: true)
        }
    }
    
    static func getHistoryOrders() -> Results<HistoryOrder> {
        let historyOrders = realm.objects(HistoryOrder.self)
        return historyOrders
    }
    
    static func configureCartFromHistoryOrder(historyOrder: HistoryOrder) {
        removeOrders()

        try! realm.write {
            let user = getUser()!
            let cart = user.cart
            
            let products = List<Product>()
            for historyProduct in historyOrder.historyProducts {
                let product = getProducts().filter { $0.product_id == historyProduct.productID }.first!
                product.countBuy = historyProduct.countBuy
                products.append(product)
            }
            cart.mobileNumber       = historyOrder.mobileNumber
            cart.deliveryAddress    = historyOrder.deliveryAddress
            cart.deliveryCity       = historyOrder.deliveryCity
            cart.deliveryAlias      = historyOrder.deliveryAlias
            cart.payment            = historyOrder.payment
            cart.ordersTotalPrice   = historyOrder.ordersTotalPrice
            cart.deliveryPrice      = historyOrder.deliveryPrice
            cart.totalPrice         = historyOrder.totalPrice
            cart.products           = products
            
            Wireframe.setBadgeValue(getOrderCounts())
        }
    }
    
    static func updateHistoryOrder(historyOrder: HistoryOrder) {
        try! realm.write {
            let findHistoryOrder = getHistoryOrders().filter { $0.id == historyOrder.id }.first
            if let findHistoryOrder = findHistoryOrder {
                findHistoryOrder.isVerified = historyOrder.isVerified
            }
        }
    }
}
