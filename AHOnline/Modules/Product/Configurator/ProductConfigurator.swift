//
//  ProductConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ProductModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ProductViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ProductViewController) {

        let presenter = ProductPresenter()
        let interactor = ProductInteractor()
        let router = ProductRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
