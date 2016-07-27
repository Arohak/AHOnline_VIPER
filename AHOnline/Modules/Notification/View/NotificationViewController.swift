//
//  NotificationViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class NotificationViewController -
class NotificationViewController: UIViewController {

    var output: NotificationViewOutput!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
}

//MARK: - extension for NotificationViewInput -
extension NotificationViewController: NotificationViewInput {
    
    func setupInitialState() {

    }
}
