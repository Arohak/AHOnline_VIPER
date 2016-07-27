//
//  ContuctUsViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ContuctUsViewController -
class ContuctUsViewController: UIViewController {

    var output: ContuctUsViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for ContuctUsViewInput -
extension ContuctUsViewController: ContuctUsViewInput {
    
    func setupInitialState() {

    }
}
