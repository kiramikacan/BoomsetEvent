//
//  GuestsPresenter.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties
class GuestsPresenter {
    var view: GuestsViewProtocol?
    var interactor: GuestsInteractorProtocol?
}

//MARK: - Protocol Methods
extension GuestsPresenter: GuestsPresenterProtocol {
    
    func fetchGuests(with eventId: Int) {
        view?.showProggress()
        interactor?.fetchGuests(with: eventId)
    }
    
    func interactor(_ interactor: GuestsInteractorProtocol, didSuccessWith data: GuestResponse) {
        var guestModels = [GuestViewModel]()
        
        for guest in data.results {
            guestModels.append(GuestViewModel(prefix: guest.getPrefix(), profileImageUrl: guest.getSelfie(), firstName: guest.getFirstName(), lastName: guest.getLastName(), email: guest.getEmail(), phone: guest.getPhone(), cellPhone: guest.getCellPhone(), workPhone: guest.getWorkPhone(), jobTitle: guest.getJobTitle(), company: guest.getCompany()))
        }
        
        view?.showGuestModels(guestModels)
        view?.closeProggress()
    }
    
    func interactor(_ interactor: GuestsInteractorProtocol, didFailWith error: ApiErrorModel) {
        view?.closeProggress()
    }
    
    
}
