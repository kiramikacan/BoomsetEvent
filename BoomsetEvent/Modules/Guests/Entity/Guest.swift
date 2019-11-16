//
//  Guest.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct Guest: Codable {
    var prefix: String?
    var selfie: String?
    var first_name: String?
    var last_name: String?
    var email: String?
    var phone: String?
    var cell_phone: String?
    var work_phone: String?
    var job_title: String?
    var company: String?
}
