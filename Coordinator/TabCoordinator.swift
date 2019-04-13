//
//  TabCoordinator.swift
//  Coordinator
//
//  Created by Nikola on 28/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import Foundation
import UIKit

class TabCoordinator: NSObject {
    
    var tabBarController: UITabBarController
    var childCoordinators: [NSObject] = []
    
    var homeCoordinator: HomeCoordinator
    var favoriteCoordinator: FavoriteCoordinator
    var cartCoordinator: CartCoordiantor
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController

        homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController())
        cartCoordinator = CartCoordiantor(navigationController: UINavigationController())
        super.init()
    }
    
    func start() {
        
        var controllers: [UIViewController] = []
        
        homeCoordinator.start()
        favoriteCoordinator.start()
        cartCoordinator.start()
        
        let homeController = homeCoordinator.navigationController
        homeController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(), selectedImage: nil)
        childCoordinators.append(homeCoordinator)
        
        let favoriteController = favoriteCoordinator.navigationController
        favoriteController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(), selectedImage: nil)
        childCoordinators.append(favoriteCoordinator)
        
        let cartController = cartCoordinator.navigationController
        cartController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(), selectedImage: nil)
        childCoordinators.append(cartController)
        
        controllers.append(homeController)
        controllers.append(favoriteController)
        controllers.append(cartController)
        
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.tabBar.isTranslucent = true
        tabBarController.delegate = self
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    
}
