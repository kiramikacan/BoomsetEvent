//
//  LoginViewInteractorProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol LoginInteractorProtocol {
    var presenter: LoginPresenterProtocol? { get set }
    func loginWithCredentials(username: String, password: String)
}
