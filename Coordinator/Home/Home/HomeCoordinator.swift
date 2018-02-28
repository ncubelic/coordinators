//
//  HomeCoordinator.swift
//  Coordinator
//
//  Created by Nikola on 27/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: NSObject {
    
    var navigationController: UINavigationController
    var childCoordinators: [NSObject] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
        navigationController.setViewControllers([homeController], animated: true)
    }
}
