//
//  ManageAddressPresenter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ManageAddressPresenter -
class ManageAddressPresenter {

    weak var view: ManageAddressViewInput!
    var interactor: ManageAddressInteractorInput!
    var router: ManageAddressRouterInput!
}

//MARK: - extension for ManageAddressViewOutput -
extension ManageAddressPresenter: ManageAddressViewOutput {
    
    func viewIsReady() {
        interactor.getDeliveries()
    }
    
    func closeButtonClicked() {
        router.dismissViewController()
    }
    
    func saveButtonClicked(json: JSON) {
        interactor.saveDeliveryAddressData(json: json)
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension ManageAddressPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc: vc)
    }
}

//MARK: - extension for DismissControllerProtocol -
extension ManageAddressPresenter: DismissControllerProtocol {
    
    func dismissViewController() {
        router.dismissViewController()
    }
}

//MARK: - extension for ManageAddressInteractorOutput -
extension ManageAddressPresenter: ManageAddressInteractorOutput {
 
    func dataIsReady(user: User?, countries: [String], citiesTuple: [(String, String)]) {
        view.setupInitialState(user: user, countries: countries, citiesTuple: citiesTuple)
    }
    
    func saveAddressIsReady() {
        router.dismissViewController()
    }
}
