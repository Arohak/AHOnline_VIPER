//
//  HelpViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HelpViewController -
class HelpViewController: UIViewController {

    var output: HelpViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for HelpViewInput -
extension HelpViewController: HelpViewInput {
    
    func setupInitialState() {

    }
}
