//
//  EventsPresenterProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol EventsPresenterProtocol {
    func fetchEvents()
    
    func interactor(_ interactor: EventsInteractorProtocol, didSuccessWith data: EventResponse)
    func interactor(_ interactor: EventsInteractorProtocol, didFailWith error: ApiErrorModel)
}
