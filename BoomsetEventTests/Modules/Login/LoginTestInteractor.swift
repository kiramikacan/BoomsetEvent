//
//  LoginTestInteractor.swift
//  BoomsetEventTests
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation
@testable import BoomsetEvent

class LoginTestInteractor: LoginInteractorProtocol {
    
    private let validUsername = "testaccount@boomset.com"
    private let validPassword = "Boomsettest123"
    
    var presenter: LoginPresenterProtocol?
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loginWithCredentials(username: String, password: String) {
        if username == validUsername && password == validPassword {
            // user successfuly authencticated
            presenter?.interactor(self, didSuccessWith: User())
        } else {
            presenter?.interactor(self, didFailWith: ApiErrorModel(type: .InvalidCredentials))
        }
    }
    
}
