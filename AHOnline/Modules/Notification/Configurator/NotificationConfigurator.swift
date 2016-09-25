//
//  NotificationConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class NotificationModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NotificationViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NotificationViewController) {

        let presenter = NotificationPresenter()
        let interactor = NotificationInteractor()
        let router = NotificationRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
