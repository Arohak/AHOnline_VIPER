//
//  ObjectsConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectsModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ObjectsViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: ObjectsViewController) {

        let presenter = ObjectsPresenter()
        let interactor = ObjectsInteractor()
        let router = ObjectsRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
