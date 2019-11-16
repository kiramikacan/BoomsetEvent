//
//  EventsPresenter.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class EventsPresenter: EventsPresenterProtocol {
    
    var view: EventsViewProtocol?
    var interactor: EventsInteractorProtocol?
    
    func fetchEvents() {
        view?.showProggress()
        interactor?.fetchEvents()
    }
    
    func interactor(_ interactor: EventsInteractorProtocol, didSuccessWith data: EventResponse) {
        view?.setEventResponse(data)
        view?.closeProggress()
    }
    
    func interactor(_ interactor: EventsInteractorProtocol, didFailWith error: ApiErrorModel) {
        view?.closeProggress()
    }
    
}