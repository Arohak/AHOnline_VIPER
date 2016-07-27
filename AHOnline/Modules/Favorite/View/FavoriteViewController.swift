//
//  FavoriteViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class FavoriteViewController -
class FavoriteViewController: UIViewController {

    var output: FavoriteViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for FavoriteViewInput -
extension FavoriteViewController: FavoriteViewInput {
    
    func setupInitialState() {

    }
}
