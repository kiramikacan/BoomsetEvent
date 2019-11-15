//
//  LoginViewInteractor.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorProtocol {
    
    var presenter: LoginPresenterProtocol?
    
    private var apiWorker: LoginApiWorkerProtocol?
    
    init(apiWorker: LoginApiWorkerProtocol) {
        self.apiWorker = apiWorker
    }
    
    func loginWithCredentials(username: String, password: String) {
        apiWorker?.loginWithCredentials(username: username, password: password) { [unowned self] (result) in
            switch result {
            case .Success(let user):
                if let user = user as? User {
                    self.presenter?.interactor(self, didSuccessWith: user)
                } else {
                    let error = ApiErrorModel(type: .NotExist)
                    self.presenter?.interactor(self, didFailWith: error)
                }
            case.Failure(let error):
                self.presenter?.interactor(self, didFailWith: error)
            }
        }
    }
    
}
