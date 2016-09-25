//
//  HomeRouter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for HomeRouter -
class HomeRouter {

}

//MARK: - extension for HomeRouterInput -
extension HomeRouter: HomeRouterInput {
    
}

//MARK: - extension for PushViewControllerProtocol -
extension HomeRouter: PushViewControllerProtocol {
    
    func pushViewController(vc: UIViewController) {
        Wireframe.pushViewController(vc: vc)
    }
}

//MARK: - extension for ModalPresentViewControllerProtocol -
extension HomeRouter: ModalPresentViewControllerProtocol {
    
    func modalPresentViewController(vc: UIViewController) {
        Wireframe.modalPresentViewController(vc: vc)
    }
}
