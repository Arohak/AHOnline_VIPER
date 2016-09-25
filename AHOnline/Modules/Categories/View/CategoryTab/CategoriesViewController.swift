//
//  CategoryTabViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class CategoriesViewController: UIViewController {

    var output: CategoriesViewOutput!
    
    var tabNavigation: CarbonTabSwipeNavigation!
    var viewControllers: [UIViewController] = []
    var selectedViewController: UIViewController!
    var categories: [Category] = []

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = WHITE
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        output.viewIsReady()
    }
    
    //MARK: -  Internal Methods -
    internal func baseConfig() {
        var items: [String] = []
        for category in categories { items.append(category.name)  }
        
        if !items.isEmpty {
            tabNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
            tabNavigation.insert(intoRootViewController: self)
            styleTab()
        }
    }
    
    internal func styleTab() {
        if let tabNavigation = tabNavigation {
            tabNavigation.setIndicatorColor(RED)
            tabNavigation.toolbar.isTranslucent = false
            tabNavigation.setTabExtraWidth(50)
            tabNavigation.setNormalColor(BLACK.withAlphaComponent(0.6))
            tabNavigation.setSelectedColor(RED, font: UIFont.boldSystemFont(ofSize: 14))
        }
    }
}

//MARK: - extension for CategoriesViewInput -
extension CategoriesViewController: CategoriesViewInput {
    
    func setupInitialState(viewControllers: [UIViewController], categories: [Category]) {
        self.viewControllers = viewControllers
        self.categories = categories
        
        baseConfig()
    }
}

//MARK: - extension for CarbonTabSwipeNavigationDelegate -
extension CategoriesViewController: CarbonTabSwipeNavigationDelegate {
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        return viewControllers[Int(index)]
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAt index: UInt) {
        selectedViewController = viewControllers[Int(index)]
        output.didSelectCategory(category: categories[Int(index)])
    }
}
