//
//  HomeViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol HomeViewOutput: DidSelectObjectProtocol {

    func viewIsReady()
    func search(keyword: String, searchType: SearchType, sort: String, kitchen: [String])
    func didSelectObjectForType(type: ObjectsType)
}
