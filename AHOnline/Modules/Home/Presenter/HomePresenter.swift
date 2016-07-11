//
//  HomePresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HomePresenter -
class HomePresenter {

    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
}

//MARK: - extension for HomeModuleInput -
extension HomePresenter: HomeModuleInput {

}

//MARK: - extension for HomeViewOutput -
extension HomePresenter: HomeViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for HomeInteractorOutput -
extension HomePresenter: HomeInteractorOutput {
 
}