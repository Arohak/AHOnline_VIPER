//
//  ClosedActionViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ClosedActionViewController: UIViewController {
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(closeAction)), animated: true)

        baseConfig()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateLocalizedStrings()
    }
    
    // MARK: - Internal Method -
    internal func baseConfig() {
        
    }
    
    internal func updateLocalizedStrings() {
        
    }
    
    //MARK: - Actions -
    func closeAction() {
        Wireframe.dismissViewController()
    }
}
