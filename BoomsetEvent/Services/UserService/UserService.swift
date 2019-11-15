//
//  UserService.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class UserService {
    
    static let shared: UserService = UserService()
    
    // To make sure that this class cannot be instantiated outside
    private init() {}
    
    private let keyToken = "UserToken"
    
    func setUserToken(_ token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: self.keyToken)
    }
    
    func getUserToken() -> String? {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: self.keyToken)
        return token
    }
}
