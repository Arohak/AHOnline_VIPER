//
//  CategoriesViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CategoriesViewController -
class CategoriesViewController: UIViewController {

    var output: CategoriesViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for CategoriesViewInput -
extension CategoriesViewController: CategoriesViewInput {
    
    func setupInitialState() {

    }
}
