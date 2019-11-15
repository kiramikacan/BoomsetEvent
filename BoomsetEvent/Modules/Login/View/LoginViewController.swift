//
//  LoginViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let interactor = LoginViewInteractor()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if username.isEmpty || password.isEmpty {
            self.showWarningMessage(message: "Username or password may not be blank!")
            return
        }
        
        self.displayProgress()
        interactor.loginWithCredentials(username: username, password: password) { (result) in
            self.dismissProgress()
            switch result {
            case .Success (_):
                print("success")
            case.Failure(let error):
                print(error.message)
                self.showErrorMessage(message: "Username or password incorrect!")
            }
        }
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
