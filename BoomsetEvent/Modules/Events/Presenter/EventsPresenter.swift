//
//  EventsPresenter.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties
class EventsPresenter {
    var view: EventsViewProtocol?
    var interactor: EventsInteractorProtocol?
}

//MARK: - Protocol Methods
extension EventsPresenter: EventsPresenterProtocol {
    
    func handleEventSelection(with selectedEvent: EventViewModel) {
        view?.gotoGuests(with: selectedEvent)
    }
    
    func fetchEvents() {
        view?.showProggress()
        interactor?.fetchEvents()
    }
    
    func interactor(_ interactor: EventsInteractorProtocol, didSuccessWith data: EventResponse, from source: DataSourceType) {
        
        var eventModels = [EventViewModel]()
        
        for event in data.results {
            eventModels.append(EventViewModel(event: event))
        }
        
        view?.showEventModels(eventModels)
        
        if eventModels.count > 0 || source == .remote {
            view?.closeProggress()
        }
    }
    
    func interactor(_ interactor: EventsInteractorProtocol, didFailWith error: ApiErrorModel, from source: DataSourceType) {
        if source == .remote {
            view?.closeProggress()
        }
    }
    
}
