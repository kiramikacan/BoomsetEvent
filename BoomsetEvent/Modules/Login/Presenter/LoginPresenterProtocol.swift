//
//  LoginViewPresenterProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol: class {
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorProtocol? { get set }
    
    func startLoginWithCredentials(username: String, password: String)
    
    func interactor(_ interactor: LoginInteractorProtocol, didSuccessWith data: User)
    func interactor(_ interactor: LoginInteractorProtocol, didFailWith error: ApiErrorModel)
    
}
