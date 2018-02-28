//
//  LoginCoordinator.swift
//  Coordinator
//
//  Created by Nikola on 26/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import Foundation
import UIKit

protocol LoginCoordinatorDelegate: class {
    func didFinishLogin()
}

class LoginCoordinator: NSObject {
    
    var navigationController: UINavigationController
    var childCoordinators: [NSObject] = []
    private var authenticateViewController: AuthenticateViewController
    
    weak var delegate: LoginCoordinatorDelegate?
    
    deinit {
        print("Deallocating \(self.description)")
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AuthenticateViewController") as! AuthenticateViewController
        self.authenticateViewController = vc
    }
    
    func start() {
        authenticateViewController.name = "This is something!"
        authenticateViewController.delegate = self
        navigationController.setViewControllers([authenticateViewController], animated: true)
    }
}


// MARK: Authentication Delegate

extension LoginCoordinator: AuthenticateDelegate {

    func authenticateUser(username: String, password: String) {
        
        let loadingIndicator = LoadingViewController()
        authenticateViewController.add(loadingIndicator)
        
        APIClient.shared?.login(withEmail: username, password: password) { [unowned self] (json, status, error) in
            loadingIndicator.remove()
            if status == 200 {
                guard let json = json as? [String: Any] else { return }
                let token = json.value(forKey: "token", defaultValue: "")
                UserDefaults.standard.setValue(token, forKey: "AccessToken")
                self.delegate?.didFinishLogin()
            }
            // TODO: show error
        }
    }
}


// MARK: Dictionary Extension

extension Dictionary where Value == Any {
    
    func value<T>(forKey key: Key, defaultValue: @autoclosure () -> T) -> T {
        guard let value = self[key] as? T else {
            return defaultValue()
        }
        return value
    }
}


// MARK: UIViewController Extension

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
