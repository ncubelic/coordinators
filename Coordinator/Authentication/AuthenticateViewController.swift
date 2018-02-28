//
//  AuthenticateViewController.swift
//  Coordinator
//
//  Created by Nikola on 27/02/2018.
//  Copyright © 2018 Ingemark. All rights reserved.
//

import UIKit

protocol AuthenticateDelegate: class {
    func authenticateUser(username: String, password: String)
}

class AuthenticateViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
    var name: String?
    
    weak var delegate: AuthenticateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name ?? nameLabel.text
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let username = usernameField.text, let password = passwordField.text else { return }
        delegate?.authenticateUser(username: username, password: password)
    }
}
