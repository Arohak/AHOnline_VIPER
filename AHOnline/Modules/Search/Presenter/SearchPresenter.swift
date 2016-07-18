//
//  SearchPresenter.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class SearchPresenter -
class SearchPresenter {

    weak var view: SearchViewInput!
    var interactor: SearchInteractorInput!
    var router: SearchRouterInput!
}

//MARK: - extension for SearchModuleInput -
extension SearchPresenter: SearchModuleInput {

}

//MARK: - extension for SearchViewOutput -
extension SearchPresenter: SearchViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for SearchInteractorOutput -
extension SearchPresenter: SearchInteractorOutput {
 
}