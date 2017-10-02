//
//  ObjectsPresenter.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ObjectsPresenter -
class ObjectsPresenter {

    weak var view: ObjectsViewInput!
    var interactor: ObjectsInteractorInput!
    var router: ObjectsRouterInput!
}

//MARK: - extension for ObjectsViewOutput -
extension ObjectsPresenter: ObjectsViewOutput {
    
    func getObjects(_ type: ObjectsRequestType, params: JSON) {
        interactor.getObjects(type, params: params)
    }
    
    func didSelectObject(object: AHObject) {
        let vc = ObjectViewController(object: object)
        _ = ObjectModuleInitializer(viewController: vc)
        
        router.pushViewController(vc: vc)
    }
}

//MARK: - extension for ObjectsInteractorOutput -
extension ObjectsPresenter: ObjectsInteractorOutput {
    
    func objectsDataIsReady(objects: [AHObject]) {
        view.updateObjectsData(objects: objects)
    }
}
