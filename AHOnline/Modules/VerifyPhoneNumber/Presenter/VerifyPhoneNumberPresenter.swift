//
//  VerifyPhoneNumberPresenter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class VerifyPhoneNumberPresenter -
class VerifyPhoneNumberPresenter {

    weak var view: VerifyPhoneNumberViewInput!
    var interactor: VerifyPhoneNumberInteractorInput!
    var router: VerifyPhoneNumberRouterInput!
}

//MARK: - extension for VerifyPhoneNumberViewOutput -
extension VerifyPhoneNumberPresenter: VerifyPhoneNumberViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for VerifyPhoneNumberInteractorOutput -
extension VerifyPhoneNumberPresenter: VerifyPhoneNumberInteractorOutput {
 
}