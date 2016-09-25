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
    func pushViewController(vc: UIViewController) {
        Wireframe.pushViewController(vc: vc)
    }
    
    func presentViewController(vc: UIViewController) {
        Wireframe.presentViewController(vc: vc)
    }
}
