//
//  HomePresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HomePresenter -
class HomePresenter {

    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
}

//MARK: - extension for HomeViewOutput -
extension HomePresenter: HomeViewOutput {
    
    func viewIsReady() {
        interactor.createUser()
        interactor.getRestaurantsHome()
    }
    
    func didSelectObject(object: AHObject) {
        interactor.getObject(id: object.id)
    }
    
    func didSelectObjectForType(type: ObjectsType) {
        let vc = ObjectsViewController()
        _ = ObjectsModuleInitializer(viewController: vc)
        vc.setParams(type: type)
        
        router.pushViewController(vc: vc)
    }
    
    func search(keyword: String, searchType: SearchType, sort: String, kitchen: [String]) {
        var vc: UIViewController!
        
        switch searchType {
        case .Restaurant:
            vc = ObjectsViewController()
            _ = ObjectsModuleInitializer(viewController: vc)
            (vc as! ObjectsViewController).setParams(search: keyword)
        
        case .Product:
            vc = ProductViewController()
            _ = ProductModuleInitializer(viewController: vc)
            (vc as! ProductViewController).setParams(requestType: .SEARCH, search: keyword)
        }

        router.pushViewController(vc: vc)
    }
}

//MARK: - extension for HomeInteractorOutput -
extension HomePresenter: HomeInteractorOutput {
 
    func createUserIsReady(user: User) {
        if !user.isVerified {
            let vc = VerifyPhoneNumberViewController()
            if !user.phone.isEmpty { vc.mobileNumber = user.phone }
            _ = VerifyPhoneNumberModuleInitializer(viewController: vc)
            router.modalPresentViewController(vc: UINavigationController(rootViewController: vc))
        }
    }
    
    func homeDataIsReady(home: Home) {
        view.setupInitialState(home: home)
    }
    
    func objectDataIsReady(object: AHObject) {
        let vc = ObjectViewController(object: object)
        _ = ObjectModuleInitializer(viewController: vc)
        
        router.pushViewController(vc: vc)
    }
}
