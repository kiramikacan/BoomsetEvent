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
    
    init() {
    }
    
    init(prefix: String?, selfie: String?, first_name: String?, last_name: String?, email: String?, phone: String?, cell_phone: String?, work_phone: String?, job_title: String?, company: String?) {
        self.prefix = prefix
        self.selfie = selfie
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone = phone
        self.cell_phone = cell_phone
        self.work_phone = work_phone
        self.job_title = job_title
        self.company = company
    }
    
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
