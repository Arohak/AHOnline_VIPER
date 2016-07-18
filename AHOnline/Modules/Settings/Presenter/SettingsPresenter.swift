//
//  SettingsPresenter.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class SettingsPresenter -
class SettingsPresenter {

    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!
}

//MARK: - extension for SettingsModuleInput -
extension SettingsPresenter: SettingsModuleInput {

}

//MARK: - extension for SettingsViewOutput -
extension SettingsPresenter: SettingsViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for SettingsInteractorOutput -
extension SettingsPresenter: SettingsInteractorOutput {
 
}