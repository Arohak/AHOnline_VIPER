//
//  MapConfigurator.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MapModuleConfigurator {

    func configureModuleForController<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? MapViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: MapViewController) {

        let presenter = MapPresenter()
        let interactor = MapInteractor()
        let router = MapRouter()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        viewController.output = presenter
    }

}
