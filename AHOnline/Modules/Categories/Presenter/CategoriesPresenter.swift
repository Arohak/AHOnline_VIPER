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
    
    var selectedCategory: Category!
    
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

//MARK: - extension for CategoriesViewOutput -
extension CategoriesPresenter: CategoriesViewOutput {
    
    func viewIsReady() {
        interactor.getCategories()
    }
    
    func didSelectCategory(category: Category) {
        selectedCategory = category
    }
    
    func didSelectSubcategoryRow(subcategory: Subcategory) {
        let vc = ObjectsViewController()
        _ = ObjectsModuleInitializer(viewController: vc)
        vc.setParams(categoryID: "\(selectedCategory.id)", subcategoryID: "\(subcategory.id)")
        
        router.pushViewController(vc: vc)
    }
}

//MARK: - extension for CategoriesInteractorOutput -
extension CategoriesPresenter: CategoriesInteractorOutput {
 
    func categoriesDataIsReady(categories: [Category]) {
        view.setupInitialState(viewControllers: createViewControllers(categories: categories), categories: categories)
    }
    
    private func createViewControllers(categories: [Category]) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        for category in categories {
            let vc = BaseCategoryViewController()
            vc.output = self
            vc.category = category
            vc.subcategories = Array(category.subcategories)
            viewControllers.append(vc)
        }
        
        return viewControllers
    }
}
