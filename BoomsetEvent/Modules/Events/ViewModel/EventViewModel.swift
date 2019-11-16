//
//  EventViewModel.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class EventViewModel {
    var event: Event
    
    var startDate: Date? = nil
    var endDate: Date? = nil
    
    init(event: Event) {
        self.event = event
        self.startDate = getDate(from: event.starts)
        self.endDate = getDate(from: event.ends)
    }
    
    func getStartDateString() -> String {
        var dateString = ""
        if let date = startDate {
            dateString = getString(from: date)
        }
        return dateString
    }
    
    func getEndDateString() -> String {
        var dateString = ""
        if let date = endDate {
            dateString = getString(from: date)
        }
        return dateString
    }
    
    private func getString(from date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .short)
    }
    
    private func getDate(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: string) // replace Date String
    }
    
}
