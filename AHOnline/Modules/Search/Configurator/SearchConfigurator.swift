//
//  SearchConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class SearchModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SearchViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: SearchViewController) {

        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
