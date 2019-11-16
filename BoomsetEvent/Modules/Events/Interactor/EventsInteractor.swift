//
//  EventsInteractor.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties & Init Method
class EventsInteractor {
    var presenter: EventsPresenterProtocol?
    
    private var apiWorker: EventsApiWorkerProtocol?
    private var cacher: EventsCacherProtocol?
    
    init(apiWorker: EventsApiWorkerProtocol, cacher: EventsCacherProtocol) {
        self.apiWorker = apiWorker
        self.cacher = cacher
    }
}

//MARK: - Protocol Methods
extension EventsInteractor: EventsInteractorProtocol {
    
    func fetchEvents() {
        
        // firstly load events from the cach
        cacher?.loadEventsFromTheCache(callback: { [unowned self] (eventResponse) in
            self.onEventsSuccessfulyFetched(eventResponse: eventResponse, sourceType: .cache)
        })
        
        // and then load events from the api
        apiWorker?.fetchEvents() { [unowned self] (result) in
            switch result {
            case .Success(let eventResponse):
                let response = eventResponse as? EventResponse
                self.cacher?.saveEventsToTheCache(eventResponse: response) // cache response getting from the api
                self.onEventsSuccessfulyFetched(eventResponse: response, sourceType: .remote)
            case.Failure(let error):
                self.presenter?.interactor(self, didFailWith: error, from: .remote)
            }
        }
    }
    
    func onEventsSuccessfulyFetched(eventResponse: EventResponse?, sourceType: DataSourceType) {
        if let response = eventResponse {
            self.presenter?.interactor(self, didSuccessWith: response, from: sourceType)
        } else {
            let error = ApiErrorModel(type: .NotExist)
            self.presenter?.interactor(self, didFailWith: error, from: sourceType)
        }
    }
    
}
