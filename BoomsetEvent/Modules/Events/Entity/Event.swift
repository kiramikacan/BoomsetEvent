//
//  Event.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct Event: Codable {
    var id: Int
    var name: String
    var group_id: Int
    var timezone: String
    var starts: String
    var ends: String
}
