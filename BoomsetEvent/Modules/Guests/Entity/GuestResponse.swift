//
//  GuestResponse.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct GuestResponse: Codable {
    var count: Int
    var previous: String?
    var next: String?
    var results: [Guest]
}
