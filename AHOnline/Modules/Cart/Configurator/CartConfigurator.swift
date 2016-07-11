//
//  CartConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class CartModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CartViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: CartViewController) {

        let presenter = CartPresenter()
        let interactor = CartInteractor()
        let router = CartRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
