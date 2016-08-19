//
//  HistoryInteractor.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HistoryInteractor -
class HistoryInteractor {

    weak var output: HistoryInteractorOutput!
    
    var user: User? {
        return DBManager.getUserCart()
    }
}

//MARK: - extension for HistoryInteractorInput -
extension HistoryInteractor: HistoryInteractorInput {
    
    func getHistoryOrders() {
        if let user = user {
            _ = APIManager.getOrders("\(user.id)")
                .subscribe(onNext: { result in
                    if result != nil {
                        for historyOrder in result["data"].arrayValue {
                            let order = HistoryOrder(data: historyOrder)
                            DBManager.updateHistoryOrder(order)
                        }
                        
                        let historyOrders = DBManager.getHistoryOrders()
                        self.output.historyOrdersDataIsReady(Array(historyOrders))
                    }
                    }, onError: { error in
                        let historyOrders = DBManager.getHistoryOrders()
                        self.output.historyOrdersDataIsReady(Array(historyOrders))
                })
        }
    }
    
    func configureCartViewControllerFromHistoryOrder(historyOrder: HistoryOrder) {
        DBManager.configureCartFromHistoryOrder(historyOrder)
    }
}