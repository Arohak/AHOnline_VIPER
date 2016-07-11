//
//  CategoriesPresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CategoriesPresenter -
class CategoriesPresenter {

    weak var view: CategoriesViewInput!
    var interactor: CategoriesInteractorInput!
    var router: CategoriesRouterInput!
}

//MARK: - extension for CategoriesModuleInput -
extension CategoriesPresenter: CategoriesModuleInput {

}

//MARK: - extension for CategoriesViewOutput -
extension CategoriesPresenter: CategoriesViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for CategoriesInteractorOutput -
extension CategoriesPresenter: CategoriesInteractorOutput {
 
}