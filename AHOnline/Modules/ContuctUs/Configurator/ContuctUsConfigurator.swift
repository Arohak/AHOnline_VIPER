//
//  ContuctUsConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ContuctUsModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ContuctUsViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: ContuctUsViewController) {

        let presenter = ContuctUsPresenter()
        let interactor = ContuctUsInteractor()
        let router = ContuctUsRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
