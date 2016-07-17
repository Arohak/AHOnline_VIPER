//
//  ObjectRouter.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for ObjectRouter -
class ObjectRouter {

}

//MARK: - extension for ObjectRouterInput -
extension ObjectRouter: ObjectRouterInput {
    
    func pushViewController(vc: UIViewController) {
        Wireframe.pushViewController(vc)
    }
}