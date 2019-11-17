//
//  LoginTestPresenter.swift
//  BoomsetEventTests
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation
@testable import BoomsetEvent

class LoginTestPresenter: LoginPresenterProtocol {
    
    var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    
    var isCredentialsEmpty = false
    var isLoginSuccessfull = false
    var isLoginFailedWithInvalidCredentials = false
    var loginFailedWithErrorMessage: String? = nil
    
    func startLoginWithCredentials(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
            self.isCredentialsEmpty = true
            return
        }
        
        interactor?.loginWithCredentials(username: username, password: password)
    }
    
    func interactor(_ interactor: LoginInteractorProtocol, didSuccessWith data: User) {
        self.isLoginSuccessfull = true
    }
    
    func interactor(_ interactor: LoginInteractorProtocol, didFailWith error: ApiErrorModel) {
        if error.type == .InvalidCredentials {
            self.isLoginFailedWithInvalidCredentials = true
        } else {
            self.loginFailedWithErrorMessage = error.localizedDescription
        }
    }
    
}
