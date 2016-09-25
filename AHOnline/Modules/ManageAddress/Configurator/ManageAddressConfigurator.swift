//
//  ManageAddressConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ManageAddressModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ManageAddressViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ManageAddressViewController) {

        let presenter = ManageAddressPresenter()
        let interactor = ManageAddressInteractor()
        let router = ManageAddressRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
