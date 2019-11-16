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
        
        guestModels.append(GuestViewModel(prefix: "myPrefix", profileImageUrl: "https://i.pravatar.cc/150?img=67", firstName: "Kirami", lastName: "Kaçan", email: "kirami.kacan@gmail.com", phone: "+90 544 531 35 06", cellPhone: "+90 555 888 66 33", workPhone: "+90 555 999 55 44", jobTitle: "Senior iOS Developer", company: "Boomset"))
        guestModels.append(GuestViewModel(prefix: "myPrefix", profileImageUrl: "https://i.pravatar.cc/150?img=67", firstName: "Ömer Asaf", lastName: "Kaçan", email: "omer.asaf@gmail.com", phone: "+90 456 67 35 06", cellPhone: "+90 555 888 66 33", workPhone: "+90 555 999 55 44", jobTitle: "Product Owner", company: "Goolge"))
        guestModels.append(GuestViewModel(prefix: "myPrefix", profileImageUrl: "https://i.pravatar.cc/150?img=67", firstName: "Kerem Ali", lastName: "Kaçan", email: "kerem.ali@gmail.com", phone: "+90 578 32 35 06", cellPhone: "+90 555 888 66 33", workPhone: "+90 555 999 55 44", jobTitle: "Senior Software Specialist", company: "Apple"))
        
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
