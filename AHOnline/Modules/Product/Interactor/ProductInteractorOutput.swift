//
//  ProductInteractorOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol ProductInteractorOutput: class {

    func productsDataIsReady(products: [Product])
    func addProductIsReady(product: Product)
    func updateProductIsReady(product: Product)
}
