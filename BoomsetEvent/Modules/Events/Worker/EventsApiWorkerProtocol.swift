//
//  EventsApiWorkerProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol EventsApiWorkerProtocol {
    func fetchEvents(callback: @escaping (ECallbackResultType) -> Void)
}
