//
//  EventsCacherProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol EventsCacherProtocol {
    func saveEventsToTheCache(eventResponse: EventResponse?)
    func loadEventsFromTheCache(callback: @escaping (EventResponse?) -> Void)
}
