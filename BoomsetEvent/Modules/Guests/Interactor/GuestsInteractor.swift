//
//  GuestsInteractor.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties
class GuestsInteractor {
    var presenter: GuestsPresenterProtocol?
}

//MARK: - Moc Data Methods
extension GuestsInteractor {
    func getMocGuests() -> [GuestViewModel] {
        var guestModels = [GuestViewModel]()
        
        guestModels.append(GuestViewModel(prefix: "myPrefix", firstName: "Kirami", lastName: "Kaçan", email: "kirami.kacan@gmail.com", phone: "+90 544 531 35 06", cellPhone: "+90 555 888 66 33", workPhone: "+90 555 999 55 44", jobTitle: "Senior iOS Developer", company: "Boomset"))
        
        return guestModels
    }
}

//MARK: - Protocol Methods
extension GuestsInteractor: GuestsInteractorProtocol {
    func fetchGuests() {
        let guestModels = getMocGuests()
        presenter?.interactor(self, didSuccessWith: guestModels)
    }
}
