//
//  HistoryConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HistoryModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HistoryViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: HistoryViewController) {

        let presenter = HistoryPresenter()
        let interactor = HistoryInteractor()
        let router = HistoryRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
