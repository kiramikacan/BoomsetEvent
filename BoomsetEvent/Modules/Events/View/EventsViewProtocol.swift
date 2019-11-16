//
//  EventsViewProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol EventsViewProtocol {
    func showProggress()
    func closeProggress()
    func showEventModels(_ events: [EventViewModel])
    
    func gotoGuests(with selectedEvent: EventViewModel)
}
