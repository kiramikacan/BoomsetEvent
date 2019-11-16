//
//  GuestsViewProtocol.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

protocol GuestsViewProtocol {
    func showProggress()
    func closeProggress()
    func showGuestModels(_ guests: [GuestViewModel], next: String?)
    func showMoreGuestModels(_ guests: [GuestViewModel], next: String?)
}
