//
//  ManageAddressInteractorOutput.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol ManageAddressInteractorOutput: class {

    func dataIsReady(user: User?, countries: [String], citiesTuple: [(String, String)])
    func saveAddressIsReady()
}
