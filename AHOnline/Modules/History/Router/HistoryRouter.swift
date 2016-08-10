//
//  HistoryRouter.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class for HistoryRouter -
class HistoryRouter {

}

//MARK: - extension for HistoryRouterInput -
extension HistoryRouter: HistoryRouterInput {
    
    func getTabControllerForIndex(index: Int) -> UIViewController {
        return Wireframe.getTabControllerForIndex(index)
    }
}

//MARK: - extension for SelectTabControllerProtocol -
extension HistoryRouter: SelectTabControllerProtocol {
    
    func selectTabControllerForIndex(index: Int) {
        Wireframe.selectTabControllerForIndex(index)
    }
}