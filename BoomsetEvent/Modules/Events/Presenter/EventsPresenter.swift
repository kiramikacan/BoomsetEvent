//
//  EventsPresenter.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class EventsPresenter {
    var view: EventsViewProtocol?
    var interactor: EventsInteractorProtocol?
}

extension EventsPresenter: EventsPresenterProtocol {
    
    func handleEventSelection() {
        view?.gotoGuests()
    }
    
    func fetchEvents() {
        view?.showProggress()
        interactor?.fetchEvents()
    }
    
    func interactor(_ interactor: EventsInteractorProtocol, didSuccessWith data: EventResponse) {
        
        var eventModels = [EventViewModel]()
        
        for event in data.results {
            eventModels.append(EventViewModel(event: event))
        }
        
        view?.showEventModels(eventModels)
        view?.closeProggress()
    }
    
    func interactor(_ interactor: EventsInteractorProtocol, didFailWith error: ApiErrorModel) {
        view?.closeProggress()
    }
    
}
