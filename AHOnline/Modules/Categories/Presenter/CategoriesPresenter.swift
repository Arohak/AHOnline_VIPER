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

//MARK: - extension for CategoriesViewOutput -
extension CategoriesPresenter: CategoriesViewOutput {
    
    func viewIsReady() {
        interactor.getCategories()
    }
    
    func didSelectCategory(category: Category) {
        interactor.selectCategory(category)
    }
    
    func didSelectSubcategoryRow(subcategory: Subcategory) {
        interactor.getObjects(subcategory)
    }
    
    func didSelectObjectRow(object: AHObject) {
        interactor.getObjectCategories(object)
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
            vc.category = category
            vc.subcategories = Array(category.subcategories)
            viewControllers.append(vc)
        }
        
        return viewControllers
    }
    
    func objectsDataIsReady(objects: [AHObject]) {
        let vc = ObjectsViewController()
        vc.output = self
        vc.objects = objects
        
        let category = Wireframe.root().viewControllers![1] as! UINavigationController
        category.pushViewController(vc, animated: true)
    }
    
    func objectCategoriesDataIsReady(object: AHObject, objectCategories: [ObjectCategory]) {
        var items: [String] = []
        for objectCategory in objectCategories { items.append(objectCategory.name)  }
        let objectDetail = ObjectDetail(object: object, items: items)
        
        let vc = ObjectDetailViewController(title: "", detail: objectDetail)
        vc.output = self
        
        let objectCategory = Wireframe.root().viewControllers![1] as! UINavigationController
        objectCategory.pushViewController(vc, animated: true)
    }
}