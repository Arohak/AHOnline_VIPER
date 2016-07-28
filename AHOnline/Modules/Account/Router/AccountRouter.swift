//
//  AccountRouter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for AccountRouter -
class AccountRouter {

}

//MARK: - extension for AccountRouterInput -
extension AccountRouter: AccountRouterInput {
    
}

//MARK: - extension for PresentViewControllerProtocol -
extension AccountRouter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        Wireframe.presentViewController(vc)
    }
}

//MARK: - extension for ModalPresentViewControllerProtocol -
extension AccountRouter: ModalPresentViewControllerProtocol {
    
    func modalPresentViewController(vc: UIViewController) {
        Wireframe.modalPresentViewController(vc)
    }
}

//MARK: - extension for PushViewControllerProtocol -
extension AccountRouter: PushViewControllerProtocol {
    
    func pushViewController(vc: UIViewController) {
        Wireframe.pushViewController(vc)
    }
}