//
//  VerifyPhoneNumberRouter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for VerifyPhoneNumberRouter -
class VerifyPhoneNumberRouter {

}

//MARK: - extension for VerifyPhoneNumberRouterInput -
extension VerifyPhoneNumberRouter: VerifyPhoneNumberRouterInput {
    
}

//MARK: - extension for PresentViewControllerProtocol -
extension VerifyPhoneNumberRouter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        Wireframe.presentViewController(vc)
    }
}

//MARK: - extension for ModalPresentViewControllerProtocol -
extension VerifyPhoneNumberRouter: ModalPresentViewControllerProtocol {
    
    func modalPresentViewController(vc: UIViewController) {
        Wireframe.modalPresentViewController(vc)
    }
}

//MARK: - extension for DismissControllerProtocol -
extension VerifyPhoneNumberRouter: DismissControllerProtocol {
    
    func dismissViewController() {
        Wireframe.dismissViewController()
    }
}