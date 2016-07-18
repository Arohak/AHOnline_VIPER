//
//  ObjectsInteractor.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ObjectsInteractor -
class ObjectsInteractor {

    weak var output: ObjectsInteractorOutput!
}

//MARK: - extension for ObjectsInteractorInput -
extension ObjectsInteractor: ObjectsInteractorInput {
    
    func getObject(id: Int) {
        _ = APIManager.getObject("\(id)")
            .subscribe(onNext: { result in
                if result != nil {
                    let object = AHObject(data: result["data"])
                    
                    self.output.objectDataIsReady(object)
                }
            })
    }
}