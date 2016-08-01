//
//  ManageAddressViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol ManageAddressViewOutput: PresentViewControllerProtocol {

    func viewIsReady()
    func closeButtonClicked()
    func saveButtonClicked(json: JSON)
}
