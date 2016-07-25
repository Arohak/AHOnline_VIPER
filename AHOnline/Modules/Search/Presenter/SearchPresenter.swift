//
//  SearchPresenter.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class SearchPresenter -
class SearchPresenter {

    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!
}

//MARK: - extension for SearchViewOutput -
extension SearchPresenter: SearchViewOutput {
    
    func viewIsReady() {

    }
    
    func search(json: JSON) {
        let vc = ProductViewController()
        _ = ProductModuleInitializer(viewController: vc)
        vc.setParams(search: json["search"].stringValue)
        
        router.pushViewController(vc)
        
//        let vc = ObjectsViewController()
//        _ = ObjectsModuleInitializer(viewController: vc)
//        vc.setParams(search: json["search"].stringValue)
//        
//        router.pushViewController(vc)
    }
}

//MARK: - extension for SearchInteractorOutput -
extension SearchPresenter: SearchInteractorOutput {
 
}