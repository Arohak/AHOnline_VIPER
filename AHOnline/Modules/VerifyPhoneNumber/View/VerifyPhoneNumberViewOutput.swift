//
//  VerifyPhoneNumberViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol VerifyPhoneNumberViewOutput: PresentViewControllerProtocol {

    func viewIsReady()
    func closeButtonClicked()
    func sendButtonClicked(number: String)
    func acceptButtonClicked(pin: String)
}
