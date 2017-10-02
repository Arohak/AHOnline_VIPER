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
    
    func settingsButtonClicked() {
        interactor.manageSettings()
    }
    
    func didSelectRow(index: Int) {        
        switch index {
        case 0:
            let vc = HistoryViewController()
            _ = HistoryModuleInitializer(viewController: vc)
            router.pushViewController(vc: vc)
            
        case 1:
            let vc = NotificationViewController()
            _ = NotificationModuleInitializer(viewController: vc)
            router.pushViewController(vc: vc)
            
        case 2:
            interactor.manageLanguage()

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

//        updateTabBarTitles()
        updateTabBarPages()
    }
    
    private func updateTabBarTitles() {
        let tabArray = Wireframe.root().tabBar.items
        
        let titles = ["home".localizedString,
                      "categories".localizedString,
                      "cart".localizedString,
                      "favorite".localizedString,
                      "profile".localizedString]
        
        for (index, tab) in tabArray!.enumerated() {
            tab.title = titles[index]
        }
    }
    
    private func updateTabBarPages() {
        let navHome = Wireframe.root().viewControllers![0] as! UINavigationController
        navHome.popToRootViewController(animated: true)
        let homeVC = Wireframe.getTab(0) as! HomeViewController
        homeVC.output.viewIsReady()

        let navCategory = Wireframe.root().viewControllers![1] as! UINavigationController
        navCategory.popToRootViewController(animated: true)
        let categoryVC = Wireframe.getTab(1) as! CategoriesViewController
        categoryVC.output.viewIsReady()
    }
}
