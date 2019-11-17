//
//  LoginTestFakeInteractor.swift
//  BoomsetEventTests
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation
@testable import BoomsetEvent

class LoginTestFakeInteractor: LoginInteractorProtocol {
    
    var presenter: LoginPresenterProtocol?
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    func loginWithCredentials(username: String, password: String) {
        presenter?.interactor(self, didFailWith: ApiErrorModel(type: .APIEndpointNotAvailable))
    }
    
}
