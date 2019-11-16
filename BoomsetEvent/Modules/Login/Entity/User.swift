//
//  User.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct User: Codable {
    private var token: String?
    
    func getToken() -> String {
        return token ?? ""
    }
}
