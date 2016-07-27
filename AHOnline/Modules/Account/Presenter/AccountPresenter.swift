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

//MARK: - extension for AccountViewOutput -
extension AccountPresenter: AccountViewOutput {
    
    func viewIsReady() {
        interactor.getUserData()
    }
    
    func historyButtonClicked() {
        interactor.getHistory()
    }
    
    func favoriteButtonClicked() {
        interactor.getFavorites()
    }
    
    func settingsButtonClicked() {
        interactor.manageSettings()
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension AccountPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc)
    }
}

//MARK: - extension for AccountInteractorOutput -
extension AccountPresenter: AccountInteractorOutput {
 
    func userDataIsReady(user: User) {
        view.setupInitialState(user)
    }
}