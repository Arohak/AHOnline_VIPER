//
//  ManageAddressViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ManageAddressViewController -
class ManageAddressViewController: UIViewController {

    var output: ManageAddressViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for ManageAddressViewInput -
extension ManageAddressViewController: ManageAddressViewInput {
    
    func setupInitialState() {

    }
}
