//
//  LoginViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        passwordTextField.isSecureTextEntry = true
        loginButton.roundCorners()
    }

}

//MARK: - Init Methods
extension LoginViewController{
    static func initViewController()->LoginViewController{
        let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
        return controller
    }
}
