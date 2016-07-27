//
//  VerifyPhoneNumberViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class VerifyPhoneNumberViewController -
class VerifyPhoneNumberViewController: UIViewController {

    var output: VerifyPhoneNumberViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for VerifyPhoneNumberViewInput -
extension VerifyPhoneNumberViewController: VerifyPhoneNumberViewInput {
    
    func setupInitialState() {

    }
}
