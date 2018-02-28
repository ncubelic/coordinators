//
//  AppCoordinator.swift
//  Coordinator
//
//  Created by Nikola on 26/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: NSObject {
    
    var rootViewController: UIViewController?
    var childCoordinators: [NSObject] = []
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if isLoggedIn() {
            showHomeScreen()
        } else {
            showLoginScreen()
        }
    }
    
    func showLoginScreen() {
        rootViewController = UINavigationController()
        window.rootViewController = rootViewController
        
        let loginCoordinator = LoginCoordinator(navigationController: rootViewController as! UINavigationController)
        loginCoordinator.start()
        loginCoordinator.delegate = self
        childCoordinators.append(loginCoordinator)
    }
    
    func showHomeScreen() {
        rootViewController = UITabBarController()
        window.rootViewController = rootViewController
        
        let tabCoordinator = TabCoordinator(tabBarController: rootViewController as! UITabBarController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
    
    private func isLoggedIn() -> Bool {
        guard let _ = UserDefaults.standard.string(forKey: "AccessToken") else {
            return false
        }
        return true
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    
    func didFinishLogin() {
        childCoordinators = childCoordinators.filter({ $0 !== self })
        showHomeScreen()
    }
}
