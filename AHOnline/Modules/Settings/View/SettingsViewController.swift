//
//  SettingsViewController.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class SettingsViewController -
class SettingsViewController: UIViewController {

    var output: SettingsViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for SettingsViewInput -
extension SettingsViewController: SettingsViewInput {
    
    func setupInitialState() {

    }
}
