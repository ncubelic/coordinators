//
//  FavoriteCoordinator.swift
//  Coordinator
//
//  Created by Nikola on 27/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCoordinator: NSObject {
    
    var navigationController: UINavigationController
    var childCoordinators: [NSObject] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoriteController = UIStoryboard(name: "Favorite", bundle: nil).instantiateInitialViewController() as! FavoriteViewController
        navigationController.setViewControllers([favoriteController], animated: true)
    }
}
