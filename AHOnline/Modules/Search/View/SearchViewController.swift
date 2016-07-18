//
//  SearchViewController.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class SearchViewController -
class SearchViewController: UIViewController {

    var output: SearchViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for SearchViewInput -
extension SearchViewController: SearchViewInput {
    
    func setupInitialState() {

    }
}
