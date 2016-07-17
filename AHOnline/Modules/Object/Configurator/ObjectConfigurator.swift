//
//  ObjectConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ObjectViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: ObjectViewController) {

        let presenter = ObjectPresenter()
        let interactor = ObjectInteractor()
        let router = ObjectRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
