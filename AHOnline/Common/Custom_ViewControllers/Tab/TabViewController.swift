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
        
        let mapVC = MapViewController()
        _ = MapModuleInitializer(viewController: mapVC)
        tempViewControllers.append(UINavigationController(rootViewController: mapVC))
        
        let accountVC = AccountViewController()
        _ = AccountModuleInitializer(viewController: accountVC)
        tempViewControllers.append(UINavigationController(rootViewController: accountVC))
        
        viewControllers = tempViewControllers
    }
    
    private func styleTab() {
        let titles = ["home".localizedString, "categories".localizedString, "cart".localizedString, "map".localizedString, "profile".localizedString]
        let imagestitle = ["img_home", "img_categories", "img_cart", "img_map", "img_profile"]

        for (index, viewController) in viewControllers!.enumerated() {
            let title           = titles[index]
            let image           = UIImage(named: imagestitle[index])
            let selectedImage   = UIImage(named: imagestitle[index] + "_selected")
            let item = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
            viewController.tabBarItem = item
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
