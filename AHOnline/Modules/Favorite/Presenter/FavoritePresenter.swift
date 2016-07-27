//
//  FavoritePresenter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class FavoritePresenter -
class FavoritePresenter {

    weak var view: FavoriteViewInput!
    var interactor: FavoriteInteractorInput!
    var router: FavoriteRouterInput!
}

//MARK: - extension for FavoriteViewOutput -
extension FavoritePresenter: FavoriteViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for FavoriteInteractorOutput -
extension FavoritePresenter: FavoriteInteractorOutput {
 
}