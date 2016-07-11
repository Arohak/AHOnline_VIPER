//
//  ClosedActionViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ClosedActionViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(closeAction)), animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions -
    func closeAction() {

    }
}
