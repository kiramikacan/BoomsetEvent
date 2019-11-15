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
    
    
    func getAuthenticatedUser() -> User? {
        return nil
    }
}
