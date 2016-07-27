//
//  HistoryViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HistoryViewController -
class HistoryViewController: UIViewController {

    var output: HistoryViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for HistoryViewInput -
extension HistoryViewController: HistoryViewInput {
    
    func setupInitialState() {

    }
}
