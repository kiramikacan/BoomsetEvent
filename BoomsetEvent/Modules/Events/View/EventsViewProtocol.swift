//
//  EventsViewProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol EventsViewProtocol {
    func setEventResponse(_ response: EventResponse)
    func showProggress()
    func closeProggress()
}