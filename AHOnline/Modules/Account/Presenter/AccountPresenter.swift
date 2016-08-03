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
        let vc = HistoryViewController()
        _ = HistoryModuleInitializer(viewController: vc)
        router.pushViewController(vc)
    }
    
    func favoriteButtonClicked() {
        let vc = FavoriteViewController()
        _ = FavoriteModuleInitializer(viewController: vc)
        router.pushViewController(vc)
    }
    
    func settingsButtonClicked() {
        interactor.manageSettings()
    }
    
    func didSelectRow(index: Int) {        
        switch index {
        case 0:
            interactor.manageLanguage()
            
        case 1:
            let vc = NotificationViewController()
            _ = NotificationModuleInitializer(viewController: vc)
            router.pushViewController(vc)
            
        case 2:
            let vc = ContuctUsViewController()
            _ = ContuctUsModuleInitializer(viewController: vc)
            router.pushViewController(vc)
            
        case 3:
            let vc = HelpViewController()
            _ = HelpModuleInitializer(viewController: vc)
            router.pushViewController(vc)

        default:
            break
        }
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension AccountPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc)
    }
}

//MARK: - extension for ModalPresentViewControllerProtocol -
extension AccountPresenter: ModalPresentViewControllerProtocol {
    
    func modalPresentViewController(vc: UIViewController) {
        router.modalPresentViewController(vc)
    }
}

//MARK: - extension for AccountInteractorOutput -
extension AccountPresenter: AccountInteractorOutput {
 
    func userDataIsReady(user: User) {
        view.setupInitialState(user)
    }
    
    func changeLanguageIsReady() {
        view.updateLocalizedStrings()
    }
}