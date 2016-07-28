//
//  HelpViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HelpViewController -
class HelpViewController: BaseViewController {

    var output: HelpViewOutput!
    
    private var helpView = HelpView()

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "help".localizedString
        output.viewIsReady()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = helpView
    }
}

//MARK: - extension for HelpViewInput -
extension HelpViewController: HelpViewInput {
    
    func setupInitialState() {

    }
}
