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
        router.pushViewController(vc: vc)
    }
    
    func favoriteButtonClicked() {
        let vc = ProductViewController()
        _ = ProductModuleInitializer(viewController: vc)
        vc.setParams(requestType: RequestType.FAVORITE, count: 3)
        
        router.pushViewController(vc: vc)
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
            router.pushViewController(vc: vc)
            
        case 2:
            let vc = ContuctUsViewController()
            _ = ContuctUsModuleInitializer(viewController: vc)
            router.pushViewController(vc: vc)
            
        case 3:
            let vc = HelpViewController()
            _ = HelpModuleInitializer(viewController: vc)
            router.pushViewController(vc: vc)

        default:
            break
        }
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension AccountPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc: vc)
    }
}

//MARK: - extension for ModalPresentViewControllerProtocol -
extension AccountPresenter: ModalPresentViewControllerProtocol {
    
    func modalPresentViewController(vc: UIViewController) {
        router.modalPresentViewController(vc: vc)
    }
}

//MARK: - extension for AccountInteractorOutput -
extension AccountPresenter: AccountInteractorOutput {
 
    func userDataIsReady(user: User) {
        view.setupInitialState(user: user)
    }
    
    func changeLanguageIsReady() {
        view.updateLocalizedStrings()
    }
}
