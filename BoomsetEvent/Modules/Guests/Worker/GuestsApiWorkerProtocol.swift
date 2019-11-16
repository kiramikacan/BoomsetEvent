//
//  GuestsApiWorkerProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol GuestsApiWorkerProtocol {
    func fetchGuests(with eventId: Int, callback: @escaping (ECallbackResultType) -> Void)
    func fetchMoreGuests(with nextUrl: String, callback: @escaping (ECallbackResultType) -> Void)
}
