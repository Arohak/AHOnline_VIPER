//
//  HistoryInteractorInput.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol HistoryInteractorInput {

    func getHistoryOrders()
    func configureCartViewControllerFromHistoryOrder(vc: CartViewController, historyOrder: HistoryOrder)
}
