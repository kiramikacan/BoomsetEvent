//
//  LoginViewController.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        presenter?.startLoginWithCredentials(username: username, password: password)
    }
    
    func onLoginSuccess(user: User?) {
        if let user = user {
            print("User successfuly logged in with Token: \(user.token)")
        } else {
            print("User successfuly logged in with missing Token")
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

extension LoginViewController: LoginViewProtocol {
    
    func gotoEvents() {
        let vc = EventsViewController.initViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: false, completion: nil)
    }
    
    func showProggress() {
        self.displayProgress()
    }
    
    func closeProggress() {
        self.dismissProgress()
    }

    func showWarningMessage() {
        self.showWarningMessage(message: "Username or password may not be blank!")
    }
    
    func showErrorMessage() {
        self.showErrorMessage(message: "Username or password incorrect!")
    }

}

//MARK: - Init Methods
extension LoginViewController{
    static func initViewController()->LoginViewController{
        let controller = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        let presenter = LoginPresenter()
        let iterator = LoginInteractor(apiWorker: LoginApiWorker())
        
        presenter.view = controller
        presenter.interactor = iterator
        iterator.presenter = presenter
        controller.presenter = presenter
        
        return controller
    }
}
