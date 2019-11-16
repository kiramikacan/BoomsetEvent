//
//  GuestsPresenterProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol GuestsPresenterProtocol {
    func fetchGuests(with eventId: Int, nextUrl: String?)
    
    func interactor(_ interactor: GuestsInteractorProtocol, didSuccessWith data: GuestResponse, from source: DataSourceType)
    func interactor(_ interactor: GuestsInteractorProtocol, didFailWith error: ApiErrorModel, from source: DataSourceType)
}
