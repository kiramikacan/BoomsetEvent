//
//  ApiErrorModel.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

public class ApiErrorModel {
    var type: EApiErrorType
    var code: String
    var message: String
    
    init(type: EApiErrorType, code: String = "", message: String = "") {
        self.type = type
        self.code = code
        self.message = message
    }
    
    var localizedDescription: String {
        get {
            return "\(type)"
        }
    }
}
