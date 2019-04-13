//
//  CartCoordiantor.swift
//  Coordinator
//
//  Created by Nikola on 13.4.2019..
//  Copyright © 2019 Ingemark. All rights reserved.
//

import Foundation
import UIKit

class CartCoordiantor: NSObject {
    
    var navigationController: UINavigationController
    var childCoordinators: [NSObject] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cartController = UIStoryboard(name: "Cart", bundle: nil).instantiateInitialViewController() as! CartViewController
        navigationController.setViewControllers([cartController], animated: true)
    }
    
}
