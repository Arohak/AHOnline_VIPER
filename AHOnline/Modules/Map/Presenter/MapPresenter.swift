//
//  MapPresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class MapPresenter -
class MapPresenter {

    weak var view: MapViewInput!
    var interactor: MapInteractorInput!
    var router: MapRouterInput!
}

//MARK: - extension for MapModuleInput -
extension MapPresenter: MapModuleInput {

}

//MARK: - extension for MapViewOutput -
extension MapPresenter: MapViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for MapInteractorOutput -
extension MapPresenter: MapInteractorOutput {
 
}