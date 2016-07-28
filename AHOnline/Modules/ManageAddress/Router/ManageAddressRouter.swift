//
//  ManageAddressRouter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for ManageAddressRouter -
class ManageAddressRouter {

}

//MARK: - extension for ManageAddressRouterInput -
extension ManageAddressRouter: ManageAddressRouterInput {
    
}

//MARK: - extension for PresentViewControllerProtocol -
extension ManageAddressRouter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        Wireframe.presentViewController(vc)
    }
}

//MARK: - extension for DismissControllerProtocol -
extension ManageAddressRouter: DismissControllerProtocol {
    
    func dismissViewController() {
        Wireframe.dismissViewController()
    }
}