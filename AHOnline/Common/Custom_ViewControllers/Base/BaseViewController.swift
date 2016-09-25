//
//  BaseViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseViewController: UIViewController, LocalizedStringsProtocol, RefreshProtocol {
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateLocalizedStrings()
    }
    
    // MARK: - Internal Method -
    internal func baseConfig() { }
    internal func updateLocalizedStrings() { }
    internal func refresh() { }
}

class BaseSearchViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "img_search"), style: .plain, target: self, action: #selector(searchAction)), animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateLocalizedStrings()
    }
    
    // MARK: - Internal Method -
    internal func baseConfig() {
        
    }
    
    internal func updateLocalizedStrings() {
        
    }
    
    //MARK: - Actions -
    func searchAction() {
        
    }
}
