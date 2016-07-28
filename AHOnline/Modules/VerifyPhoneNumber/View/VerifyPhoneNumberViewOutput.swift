//
//  VerifyPhoneNumberViewOutput.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

protocol VerifyPhoneNumberViewOutput: PresentViewControllerProtocol, DismissControllerProtocol {

    func viewIsReady()
    func sendButtonClicked(number: String)
    func acceptButtonClicked(pin: String)
}
