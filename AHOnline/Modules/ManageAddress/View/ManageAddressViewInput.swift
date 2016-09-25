//
//  ManageAddressViewInput.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol ManageAddressViewInput: class {

    func setupInitialState(user: User?, countries: [String], citiesTuple: [(String, String)])
}
