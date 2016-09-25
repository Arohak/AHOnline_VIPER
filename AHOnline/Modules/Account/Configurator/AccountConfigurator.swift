//
//  AccountConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class AccountModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AccountViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AccountViewController) {

        let presenter = AccountPresenter()
        let interactor = AccountInteractor()
        let router = AccountRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
