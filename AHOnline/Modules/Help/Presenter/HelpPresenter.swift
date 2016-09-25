//
//  HelpPresenter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HelpPresenter -
class HelpPresenter {

    weak var view: HelpViewInput!
    var interactor: HelpInteractorInput!
    var router: HelpRouterInput!
}

//MARK: - extension for HelpViewOutput -
extension HelpPresenter: HelpViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for HelpInteractorOutput -
extension HelpPresenter: HelpInteractorOutput {
 
}