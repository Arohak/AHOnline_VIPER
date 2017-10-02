//
//  AccountViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol AccountViewOutput: PresentViewControllerProtocol {

    func viewIsReady()
    func settingsButtonClicked()
    func didSelectRow(index: Int)
}
