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
        interactor.getRestaurantsHome()
    }
    
    func didSelectObject(object: AHObject) {
        interactor.getObject(object.id)
    }
    
    func didSelectObjectForType(type: ObjectsType) {
        let vc = ObjectsViewController()
        _ = ObjectsModuleInitializer(viewController: vc)
        vc.setParams(type: type)
        
        router.pushViewController(vc)
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
            (vc as! ProductViewController).setParams(search: keyword)
        }

        router.pushViewController(vc)
    }
}

//MARK: - extension for HomeInteractorOutput -
extension HomePresenter: HomeInteractorOutput {
 
    func homeDataIsReady(home: Home) {
        view.setupInitialState(home)
    }
    
    func objectDataIsReady(object: AHObject) {
        let vc = ObjectViewController(object: object)
        _ = ObjectModuleInitializer(viewController: vc)
        
        router.pushViewController(vc)
    }
}