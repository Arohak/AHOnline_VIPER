//
//  HomeInteractor.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HomeInteractor -
class HomeInteractor {

    weak var output: HomeInteractorOutput!
}

//MARK: - extension for HomeInteractorInput -
extension HomeInteractor: HomeInteractorInput {
    
    func getRestaurantsHome() {
        _ = APIManager.getRestaurantsHome()
            .subscribe(onNext: { result in
                if result != nil {
                    let home = Home(data: result["data"])
                    self.output.homeDataIsReady(home)
                }
            })
    }
    
    func getObject(object: AHObject) {
        _ = APIManager.getObject("\(object.id)")
            .subscribe(onNext: { result in
                if result != nil {
                    let object = AHObject(data: result["data"])
                    self.output.objectDataIsReady(object)
                }
            })
    }
}