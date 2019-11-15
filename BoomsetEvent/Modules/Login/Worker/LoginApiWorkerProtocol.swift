//
//  LoginApiWorkerProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol LoginApiWorkerProtocol {
    func loginWithCredentials(username: String, password: String, callback:@escaping (ECallbackResultType) -> Void )
}
