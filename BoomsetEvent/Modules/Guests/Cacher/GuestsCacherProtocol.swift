//
//  GuestsCacherProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol GuestsCacherProtocol {
    func saveGuestsToTheCache(guestResponse: GuestResponse?, for eventId: Int)
    func loadGuestsFromTheCache(for eventId: Int, callback: @escaping (GuestResponse?) -> Void)
}
