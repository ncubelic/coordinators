//
//  LoginViewController.swift
//  Coordinator
//
//  Created by Nikola on 26/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import UIKit

protocol LoginDelegate: class {
    func didClickLogin()
}

class LoginViewController: UIViewController {

    var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .gray
        textField.placeholder = "Username"
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.titleLabel?.text = "Login"
        return button
    }()
    
    weak var delegate: LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
        view.layoutIfNeeded()
        
        loginButton.addTarget(self, action: #selector(didClickLogin), for: .touchUpInside)
    }
    
    @objc func didClickLogin() {
        delegate?.didClickLogin()
    }
    
}

extension LoginViewController {
    
    private func addSubviews() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
    }
}
