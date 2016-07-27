//
//  NotificationPresenter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class NotificationPresenter -
class NotificationPresenter {

    weak var view: NotificationViewInput!
    var interactor: NotificationInteractorInput!
    var router: NotificationRouterInput!
}

//MARK: - extension for NotificationViewOutput -
extension NotificationPresenter: NotificationViewOutput {
    
    func viewIsReady() {

    }
}

//MARK: - extension for NotificationInteractorOutput -
extension NotificationPresenter: NotificationInteractorOutput {
 
}