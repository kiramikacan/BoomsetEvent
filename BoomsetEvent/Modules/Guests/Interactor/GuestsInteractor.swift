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
    
    init(apiWorker: GuestsApiWorkerProtocol) {
        self.apiWorker = apiWorker
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
    func fetchGuests(with eventId: Int) {
        
        // close moc data, the data will be getting from the api
//        let guestModels = getMocGuests()
//        presenter?.interactor(self, didSuccessWith: guestModels)
        
        apiWorker?.fetchGuests(eventId: eventId) { [unowned self] (result) in
            switch result {
            case .Success(let eventResponse):
                if let response = eventResponse as? GuestResponse {
                    self.presenter?.interactor(self, didSuccessWith: response)
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
