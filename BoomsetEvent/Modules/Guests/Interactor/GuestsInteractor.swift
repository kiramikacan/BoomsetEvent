//
//  GuestsInteractor.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties & Init Method
class GuestsInteractor {
    
    var presenter: GuestsPresenterProtocol?
    
    private var apiWorker: GuestsApiWorkerProtocol?
    private var cacher: GuestsCacherProtocol?
    
    init(apiWorker: GuestsApiWorkerProtocol, cacher: GuestsCacherProtocol) {
        self.apiWorker = apiWorker
        self.cacher = cacher
    }
}

//MARK: - Moc Data Methods
extension GuestsInteractor {
    func getMocGuests() -> GuestResponse {

        var guests = [Guest]()
        
        guests.append(Guest())
        
        guests.append(Guest(prefix: "myPrefix", selfie: "https://i.pravatar.cc/150?img=63", first_name: "Kirami", last_name: "Kaçan", email: "kirami.kacan@gmail.com", phone: "+90 544 531 35 06", cell_phone: "+90 555 888 66 33", work_phone: "+90 555 999 55 44", job_title: "Senior iOS Developer", company: "Boomset"))
        
        guests.append(Guest(prefix: "myPrefix", selfie: "https://i.pravatar.cc/150?img=67", first_name: "Ömer Asaf", last_name: "Kaçan", email: "omer.asaf@gmail.com", phone: "+90 456 67 35 06", cell_phone: "+90 555 888 66 33", work_phone: "+90 555 999 55 44", job_title: "Product Owner", company: "Goolge"))
        
        guests.append(Guest(prefix: "myPrefix", selfie: "https://i.pravatar.cc/150?img=68", first_name: "Kerem Ali", last_name: "Kaçan", email: "kerem.ali@gmail.com", phone: "+90 578 32 35 06", cell_phone: "+90 555 888 66 33", work_phone: "+90 555 999 55 44", job_title: "Senior Software Specialist", company: "Apple"))
        
        
        let response = GuestResponse(count: 0, previous: nil, next: nil, results: guests)
        
        return response
    }
}

//MARK: - Protocol Methods
extension GuestsInteractor: GuestsInteractorProtocol {
    
    func fetchMoreGuests(with nextUrl: String) {
        let url = nextUrl.replacingOccurrences(of: "load_start", with: "timestamp").replacingOccurrences(of: "%", with: ":").replacingOccurrences(of: "rest/", with: "")
        apiWorker?.fetchMoreGuests(with: url) { [unowned self] (result) in
            self.handleResponse(result: result)
        }
    }
    
    func fetchGuests(with eventId: Int) {
        
        // close moc data, the data will be getting from the api
//        let guestModels = getMocGuests()
//        presenter?.interactor(self, didSuccessWith: guestModels)
        
        // firstly load events from the cach
        cacher?.loadGuestsFromTheCache(for: eventId, callback: { (guestResponse) in
            self.onGuestsSuccessfulyFetched(guestResponse: guestResponse, sourceType: .cache)
        })
        
        apiWorker?.fetchGuests(with: eventId) { [unowned self] (result) in
            self.handleResponse(with: eventId, result: result)
        }
    }
    
    func handleResponse(with eventId: Int? = nil, result: ECallbackResultType) {
        switch result {
        case .Success(let guestResponse):
            let response = guestResponse as? GuestResponse
            if let eventId = eventId {
                self.cacher?.saveGuestsToTheCache(guestResponse: response, for: eventId)// cache response getting from the api
            }
            self.onGuestsSuccessfulyFetched(guestResponse: response, sourceType: .remote)
        case.Failure(let error):
            self.presenter?.interactor(self, didFailWith: error, from: .remote)
        }
    }
    
    func onGuestsSuccessfulyFetched(guestResponse: GuestResponse?, sourceType: DataSourceType) {
        if let response = guestResponse {
            self.presenter?.interactor(self, didSuccessWith: response, from: sourceType)
        } else {
            let error = ApiErrorModel(type: .NotExist)
            self.presenter?.interactor(self, didFailWith: error, from: sourceType)
        }
    }
    
}
