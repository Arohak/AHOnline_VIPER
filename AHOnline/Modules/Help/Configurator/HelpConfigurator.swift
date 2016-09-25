//
//  HelpConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HelpModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HelpViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: HelpViewController) {

        let presenter = HelpPresenter()
        let interactor = HelpInteractor()
        let router = HelpRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
