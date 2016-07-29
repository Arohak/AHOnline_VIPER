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
    
    func saveButtonClicked(address: DeliveryAddress) {
        interactor.saveDeliveryAddressData(address)
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension ManageAddressPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc)
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
 
    func dataIsReady(countries: [String], cities: [String]) {
        view.setupInitialState(countries, cities: cities)
    }
}