//
//  ProductViewInput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol ProductViewInput: class {

    func setupInitialState(products: [Product])
    func addProduct(product: Product)
    func updateProduct(product: Product)
}
