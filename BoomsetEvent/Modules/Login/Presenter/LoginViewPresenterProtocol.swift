//
//  LoginViewPresenterProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol LoginViewPresenterProtocol: class {
    func startLoginWithCredentials(username: String, password: String)
    
    func interactor(_ interactor: LoginViewInteractorProtocol, didSuccessWith user: User)
    func interactor(_ interactor: LoginViewInteractorProtocol, didFailWith error: ApiErrorModel)
    
}
