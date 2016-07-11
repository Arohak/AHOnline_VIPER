//
//  AccountPresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class AccountPresenter -
class AccountPresenter {

    weak var view: AccountViewInput!
    var interactor: AccountInteractorInput!
    var router: AccountRouterInput!
}

//MARK: - extension for AccountModuleInput -
extension AccountPresenter: AccountModuleInput {

}

//MARK: - extension for AccountViewOutput -
extension AccountPresenter: AccountViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for AccountInteractorOutput -
extension AccountPresenter: AccountInteractorOutput {
 
}