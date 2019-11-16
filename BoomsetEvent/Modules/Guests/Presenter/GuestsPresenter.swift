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
    
    func fetchGuests() {
        interactor?.fetchGuests()
    }
    
    func interactor(_ interactor: GuestsInteractorProtocol, didSuccessWith data: [GuestViewModel]) {
        view?.showGuests(data)
    }
    
}
