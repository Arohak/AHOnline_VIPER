//
//  MapInteractor.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class MapInteractor -
class MapInteractor {

    weak var output: MapInteractorOutput!
}

//MARK: - extension for MapInteractorInput -
extension MapInteractor: MapInteractorInput {
    
    func getObjects(json: JSON) {
        _ = ObjectEndpoint.getObjects(.WithLimit, json: json)
            .subscribe(onNext: { result in
                if let result = result {
                    var objects: [AHObject] = []
                    for item in result["data"].arrayValue {
                        objects.append(AHObject(data: item))
                    }
                    
                    self.output.objectsDataIsReady(objects: objects)
                }
            })
    }
    
    func getNearstObjects(json: JSON) {
        _ = ObjectEndpoint.getNeartObjects(json)
            .subscribe(onNext: { result in
                if let result = result {
                    var objects: [AHObject] = []
                    for item in result["data"].arrayValue {
                        objects.append(AHObject(data: item))
                    }
                    
                    self.output.objectsDataIsReady(objects: objects)
                }
            })
    }
}
