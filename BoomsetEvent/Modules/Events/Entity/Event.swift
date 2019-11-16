//
//  Event.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct Event: Codable {
    private var id: Int
    private var name: String?
    private var starts: String?
    private var ends: String?
    
    func getId() -> Int {
        return id
    }
    func getName() -> String {
        return name ?? ""
    }
    func getStarts() -> String {
        return starts ?? ""
    }
    func getEnds() -> String {
        return ends ?? ""
    }
}
