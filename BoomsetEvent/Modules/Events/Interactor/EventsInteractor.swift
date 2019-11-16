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
    
    init(apiWorker: EventsApiWorkerProtocol) {
        self.apiWorker = apiWorker
    }
}

//MARK: - Protocol Methods
extension EventsInteractor: EventsInteractorProtocol {
    
    func fetchEvents() {
        apiWorker?.fetchEvents() { [unowned self] (result) in
            switch result {
            case .Success(let eventResponse):
                if let eventResponse = eventResponse as? EventResponse {
                    self.presenter?.interactor(self, didSuccessWith: eventResponse)
                } else {
                    let error = ApiErrorModel(type: .NotExist)
                    self.presenter?.interactor(self, didFailWith: error)
                }
            case.Failure(let error):
                self.presenter?.interactor(self, didFailWith: error)
            }
        }
    }
    
}
