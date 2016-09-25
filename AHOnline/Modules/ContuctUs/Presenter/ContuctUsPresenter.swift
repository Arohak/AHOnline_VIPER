//
//  ContuctUsPresenter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ContuctUsPresenter -
class ContuctUsPresenter {

    weak var view: ContuctUsViewInput!
    var interactor: ContuctUsInteractorInput!
    var router: ContuctUsRouterInput!
}

//MARK: - extension for ContuctUsViewOutput -
extension ContuctUsPresenter: ContuctUsViewOutput {
    
    func viewIsReady() {

    }
    
    func didSelectRow(index: Int) {
        
    }
    
    func facebookButtonClicked() {
        
    }
    
    func twitterButtonClicked() {
        
    }
    
    func youtubeButtonClicked() {
        
    }
}

//MARK: - extension for ContuctUsInteractorOutput -
extension ContuctUsPresenter: ContuctUsInteractorOutput {
 
}