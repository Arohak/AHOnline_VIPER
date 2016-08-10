//
//  HistoryRouterInput.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol HistoryRouterInput: SelectTabControllerProtocol {

    func getTabControllerForIndex(index: Int) -> UIViewController
}
