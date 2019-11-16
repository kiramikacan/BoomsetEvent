//
//  GuestViewModel.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class GuestViewModel {
    var prefix: String
    var firstName: String
    var lastName: String
    
    var email: String
    var phone: String
    var cellPhone: String
    var workPhone: String
    
    var jobTitle: String
    var company: String
    
    init(prefix: String, firstName: String, lastName: String, email: String, phone: String, cellPhone: String, workPhone: String, jobTitle: String, company: String) {
        self.prefix = prefix
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.cellPhone = cellPhone
        self.workPhone = workPhone
        self.jobTitle = jobTitle
        self.company = company
    }
}
