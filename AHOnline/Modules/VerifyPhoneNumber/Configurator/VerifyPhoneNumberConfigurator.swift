//
//  VerifyPhoneNumberConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class VerifyPhoneNumberModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? VerifyPhoneNumberViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: VerifyPhoneNumberViewController) {

        let presenter = VerifyPhoneNumberPresenter()
        let interactor = VerifyPhoneNumberInteractor()
        let router = VerifyPhoneNumberRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
