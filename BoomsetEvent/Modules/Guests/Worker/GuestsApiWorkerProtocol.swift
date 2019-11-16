//
//  GuestsApiWorkerProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol GuestsApiWorkerProtocol {
    func fetchGuests(eventId: Int, callback: @escaping (ECallbackResultType) -> Void)
}
