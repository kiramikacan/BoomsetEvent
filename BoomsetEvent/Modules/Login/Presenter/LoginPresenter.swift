//
//  LoginViewPresenter.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {

    var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    
    func startLoginWithCredentials(username: String, password: String) {
        
        if username.isEmpty || password.isEmpty {
            view?.showWarningMessage()
            return
        }
        
        view?.showProggress()
        interactor?.loginWithCredentials(username: username, password: password)
    }
    
    func interactor(_ interactor: LoginInteractorProtocol, didSuccessWith user: User) {
        // persist user - save user token to the keychain
        UserService.shared.setUserToken(user.token)
        
        view?.closeProggress()
        view?.gotoEvents()
    }
    
    func interactor(_ interactor: LoginInteractorProtocol, didFailWith error: ApiErrorModel) {
        view?.closeProggress()
        view?.showErrorMessage()
    }
    
}
