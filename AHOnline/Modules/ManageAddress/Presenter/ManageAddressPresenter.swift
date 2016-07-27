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

    }
}

//MARK: - extension for ManageAddressInteractorOutput -
extension ManageAddressPresenter: ManageAddressInteractorOutput {
 
}