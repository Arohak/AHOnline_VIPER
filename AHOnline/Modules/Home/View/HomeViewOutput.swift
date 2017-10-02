//
//  HomeViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol HomeViewOutput: DidSelectObjectProtocol {

    func checkUser()
    func viewIsReady()
    func mapButtonClicked()
    func search(keyword: String, searchType: SearchType, sort: String, kitchen: [String])
    func didSelectObjectForType(type: ObjectsType)
}
