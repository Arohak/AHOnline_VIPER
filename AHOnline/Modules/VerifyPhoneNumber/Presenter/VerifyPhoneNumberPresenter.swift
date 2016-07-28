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
    
    func closeButtonClicked() {
        router.dismissViewController()
    }
    
    func sendButtonClicked(number: String) {
        interactor.send(number)
    }
    
    func acceptButtonClicked(pin: String) {
        interactor.accept(pin)
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension VerifyPhoneNumberPresenter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        router.presentViewController(vc)
    }
}

//MARK: - extension for VerifyPhoneNumberInteractorOutput -
extension VerifyPhoneNumberPresenter: VerifyPhoneNumberInteractorOutput {
 
    func sendDataIsReady() {
        
    }
    
    func acceptDataIsReady() {
        let vc = ManageAddressViewController()
        _ = ManageAddressModuleInitializer(viewController: vc)
        router.modalPresentViewController(UINavigationController(rootViewController: vc))
    }
}