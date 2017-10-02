//
//  ObjectsRouter.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for ObjectsRouter -
class ObjectsRouter {

}

//MARK: - extension for ObjectsRouterInput -
extension ObjectsRouter: ObjectsRouterInput {
    
    func pushViewController(vc: UIViewController) {
        Wireframe.push(vc)
    }
}
