//
//  SettingsConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class SettingsModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SettingsViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: SettingsViewController) {

        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor()
        let router = SettingsRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
