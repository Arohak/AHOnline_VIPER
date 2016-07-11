//
//  CartPresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CartPresenter -
class CartPresenter {

    weak var view: CartViewInput!
    var interactor: CartInteractorInput!
    var router: CartRouterInput!
}

//MARK: - extension for CartModuleInput -
extension CartPresenter: CartModuleInput {

}

//MARK: - extension for CartViewOutput -
extension CartPresenter: CartViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for CartInteractorOutput -
extension CartPresenter: CartInteractorOutput {
 
}