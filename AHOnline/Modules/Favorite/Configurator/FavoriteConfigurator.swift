//
//  FavoriteConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class FavoriteModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? FavoriteViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: FavoriteViewController) {

        let presenter = FavoritePresenter()
        let interactor = FavoriteInteractor()
        let router = FavoriteRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
