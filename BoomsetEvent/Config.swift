//
//  Config.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct Config {
    
    // This is private because the use of 'appConfiguration' is preferred.
    private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    
    // This can be used to add debug statements.
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    static var ApiBaseUrl: String {
        let mBaseUrl = "https://www.boomset.com"
        /*
        if isDebug {
            mBaseUrl = "http://dev.boomset.com" // should be ?
        }
        */
        return mBaseUrl
    }
    
}
