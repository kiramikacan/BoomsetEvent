//
//  Guest.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

struct Guest: Codable {
    private var prefix: String?
    private var selfie: String?
    private var first_name: String?
    private var last_name: String?
    private var email: String?
    private var phone: String?
    private var cell_phone: String?
    private var work_phone: String?
    private var job_title: String?
    private var company: String?
    
    func getPrefix() -> String {
        return prefix ?? ""
    }
    func getSelfie() -> String {
        return selfie ?? ""
    }
    func getFirstName() -> String {
        return first_name ?? ""
    }
    func getLastName() -> String {
        return last_name ?? ""
    }
    func getEmail() -> String {
        return email ?? ""
    }
    func getPhone() -> String {
        return phone ?? ""
    }
    func getCellPhone() -> String {
        return cell_phone ?? ""
    }
    func getWorkPhone() -> String {
        return work_phone ?? ""
    }
    func getJobTitle() -> String {
        return job_title ?? ""
    }
    func getCompany() -> String {
        return company ?? ""
    }
}
