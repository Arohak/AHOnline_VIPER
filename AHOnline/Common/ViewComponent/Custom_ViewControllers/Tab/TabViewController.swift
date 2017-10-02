//
//  TabBarViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class TabBarViewController -
class TabBarViewController: UITabBarController {
        
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseConfig()
    }
    
    //MARK: -  Private Methods -
    private func baseConfig() {
        addViewControllers()
        styleTab()
    }
    
    private func addViewControllers() {
        var tempViewControllers: [UIViewController] = []
        
        let homeVC = HomeViewController()
        _ = HomeModuleInitializer(viewController: homeVC)
        tempViewControllers.append(UINavigationController(rootViewController: homeVC))
        
        let categoriesVC = CategoriesViewController()
        _ = CategoriesModuleInitializer(viewController: categoriesVC)
        tempViewControllers.append(UINavigationController(rootViewController: categoriesVC))
        
        let cartVC = CartViewController()
        _ = CartModuleInitializer(viewController: cartVC)
        tempViewControllers.append(UINavigationController(rootViewController: cartVC))
        
        let favoriteVC = ProductViewController()
        _ = ProductModuleInitializer(viewController: favoriteVC)
        favoriteVC.setParams(requestType: ProductsRequestType.Favorite, count: 2)
        tempViewControllers.append(UINavigationController(rootViewController: favoriteVC))
        
        let accountVC = AccountViewController()
        _ = AccountModuleInitializer(viewController: accountVC)
        tempViewControllers.append(UINavigationController(rootViewController: accountVC))
        
        viewControllers = tempViewControllers
    }
    
    private func styleTab() {
        let imagestitle = ["img_home",
                           "img_categories",
                           "img_cart",
                           "img_favorite",
                           "img_profile"]
        
        for (index, viewController) in viewControllers!.enumerated() {
            let image           = UIImage(named: imagestitle[index])
            let selectedImage   = UIImage(named: imagestitle[index] + "_selected")
            let item = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            
            viewController.tabBarItem = item

//            let titles = ["home".localizedString,
//                          "categories".localizedString,
//                          "cart".localizedString,
//                          "favorite".localizedString,
//                          "profile".localizedString]
//            
//            let imagestitle = ["img_home",
//                               "img_categories",
//                               "img_cart",
//                               "img_favorite",
//                               "img_profile"]
//            
//            let title           = titles[index]
//            let image           = UIImage(named: imagestitle[index])
//            let selectedImage   = UIImage(named: imagestitle[index] + "_selected")
//            let item = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
//            item.imageInsets = UIEdgeInsets(top: -1, left: 0, bottom: 1, right: 0)
//            item.titlePositionAdjustment = UIOffsetMake(0, -4.0)
//
//            viewController.tabBarItem = item
        }
    }
}

//MARK: - extension for UITabBarControllerDelegate -
extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    func tabBarController(tabBarController: UITabBarController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
     
        return nil
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil
    }
}
