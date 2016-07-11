//
//  CategoriesPresenter.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CategoriesPresenter -
class CategoriesPresenter {

    weak var view: CategoriesViewInput!
    var interactor: CategoriesInteractorInput!
    var router: CategoriesRouterInput!
    
    private func createViewControllers() -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        let restaurantVC = RestaurantViewController()
        restaurantVC.output = self
        viewControllers.append(restaurantVC)
        
        let shopVC = ShopViewController()
        shopVC.output = self
        viewControllers.append(shopVC)
        
        let flowerVC = FlowerViewController()
        flowerVC.output = self
        viewControllers.append(flowerVC)
        
        let hotelVC = HotelViewController()
        hotelVC.output = self
        viewControllers.append(hotelVC)
        
        viewControllers.append(UIViewController())
        
        return viewControllers
    }
}

//MARK: - extension for CategoriesModuleInput -
extension CategoriesPresenter: CategoriesModuleInput {

}

//MARK: - extension for CategoriesViewOutput -
extension CategoriesPresenter: CategoriesViewOutput {
    
    func viewIsReady() {
        interactor.getCategories()
    }
}

//MARK: - extension for CategoriesInteractorOutput -
extension CategoriesPresenter: CategoriesInteractorOutput {
 
    func categoriesDataIsReady(categories: [Category]) {
        view.setupInitialState(createViewControllers(categories), categories: categories)
    }
    
    private func createViewControllers(categories: [Category]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        for category in categories {
            let vc = BaseCategoryViewController()
            vc.output = self
            vc.subCategories = Array(category.subCategories)
            viewControllers.append(vc)
        }
        
        return viewControllers
    }
}