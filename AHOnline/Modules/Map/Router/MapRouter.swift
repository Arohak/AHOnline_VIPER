//
//  MapRouter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for MapRouter -
class MapRouter {

}

//MARK: - extension for MapRouterInput -
extension MapRouter: MapRouterInput {

}

//MARK: - extension for PushViewControllerProtocol -
extension MapRouter: PushViewControllerProtocol {
    
    func pushViewController(vc: UIViewController) {
        Wireframe.push(vc)
    }
}

//MARK: - extension for PresentViewControllerProtocol -
extension MapRouter: PresentViewControllerProtocol {
    
    func presentViewController(vc: UIViewController) {
        Wireframe.present(vc)
    }
}

//MARK: - extension for DismissControllerProtocol -
extension MapRouter: DismissControllerProtocol {
    
    func dismissViewController() {
        Wireframe.dismiss()
    }
}
