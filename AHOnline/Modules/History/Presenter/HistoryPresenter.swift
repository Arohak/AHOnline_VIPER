//
//  HistoryPresenter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HistoryPresenter -
class HistoryPresenter {

    weak var view: HistoryViewInput!
    var interactor: HistoryInteractorInput!
    var router: HistoryRouterInput!
}

//MARK: - extension for HistoryViewOutput -
extension HistoryPresenter: HistoryViewOutput {
    
    func viewIsReady() {
        interactor.getHistoryOrders()
    }
    
    func didSelectHistoryOrder(historyOrder: HistoryOrder) {
        interactor.configureCartViewControllerFromHistoryOrder(historyOrder)
        
        router.selectTabControllerForIndex(2)
    }
}

//MARK: - extension for HistoryInteractorOutput -
extension HistoryPresenter: HistoryInteractorOutput {
 
    func historyOrdersDataIsReady(historyOrders: [HistoryOrder]) {
        view.setupInitialState(historyOrders)
    }
}