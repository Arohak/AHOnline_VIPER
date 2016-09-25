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
    
    func closeButtonClicked() {
        router.dismissViewController()
    }
    
    func sendButtonClicked(number: String) {
        interactor.send(number: number)
    }
    
    func acceptButtonClicked(pin: String) {
        interactor.accept(pin: pin)
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension VerifyPhoneNumberPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc: vc)
    }
}

//MARK: - extension for VerifyPhoneNumberInteractorOutput -
extension VerifyPhoneNumberPresenter: VerifyPhoneNumberInteractorOutput {

    func sendPhoneIsReady() {
        view.enableSendButton()
    }
    
    func acceptDataIsReady() {
        router.dismissViewController()
        
        let vc = ManageAddressViewController()
        _ = ManageAddressModuleInitializer(viewController: vc)
        router.modalPresentViewController(vc: UINavigationController(rootViewController: vc))
    }
}
