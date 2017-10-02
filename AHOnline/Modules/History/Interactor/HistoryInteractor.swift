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
        return DBHelper.getUserCart()
    }
}

//MARK: - extension for HistoryInteractorInput -
extension HistoryInteractor: HistoryInteractorInput {
    
    func getHistoryOrders() {
        if let user = user {
            _ = OrderEndpoint.getOrders("\(user.id)")
                .subscribe(onNext: { result in
                    if let result = result {
                        for historyOrder in result["data"].arrayValue {
                            let order = HistoryOrder(data: historyOrder)
                            DBHelper.updateHistoryOrder(historyOrder: order)
                        }
                        
                        let historyOrders = DBHelper.getHistoryOrders()
                        self.output.historyOrdersDataIsReady(historyOrders: Array(historyOrders))
                    }
                    }, onError: { error in
                        let historyOrders = DBHelper.getHistoryOrders()
                        self.output.historyOrdersDataIsReady(historyOrders: Array(historyOrders))
                })
        }
    }
    
    func configureCartViewControllerFromHistoryOrder(historyOrder: HistoryOrder) {
        DBHelper.configureCartFromHistoryOrder(historyOrder: historyOrder)
    }
}
