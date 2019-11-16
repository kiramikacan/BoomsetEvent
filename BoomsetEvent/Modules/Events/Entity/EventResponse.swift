//
//  EventResponse.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct EventResponse: Codable {
    var count: Int
    var previous: Int?
    var next: Int?
    var results: [Event]
}
