//
//  EventsCacher.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties & Method
class EventsCacher {
    
    private let keyEventsJsonString = "BoomsetEvent_EventsJsonString"
    
    private func setJsonString(jsonString: String) {
        let defaults = UserDefaults.standard
        defaults.set(jsonString, forKey: keyEventsJsonString)
    }
    
    private func getJsonString() -> String? {
        let defaults = UserDefaults.standard
        let jsonString: String? = defaults.object(forKey: keyEventsJsonString) as? String
        return jsonString
    }
}

//MARK: - Protocol Methods
extension EventsCacher: EventsCacherProtocol {
    
    func saveEventsToTheCache(eventResponse: EventResponse?) {
        DispatchQueue.global().async { [weak self] in
            //Encode to Json format
            if let encodedObject = try? JSONEncoder().encode(eventResponse), let encodedObjectJsonString = String(data: encodedObject, encoding: .utf8)
            {
                self?.setJsonString(jsonString: encodedObjectJsonString)
            }
        }
    }
    
    func loadEventsFromTheCache(callback: @escaping (EventResponse?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            var eventResponse: EventResponse?
            if let jsonString = self?.getJsonString(), let jsonData = jsonString.data(using: .utf8) {
                do
                {
                    eventResponse = try JSONDecoder().decode(EventResponse.self, from: jsonData)
                } catch {
                    print("error while json decoding")
                }
            }
            
            DispatchQueue.main.async {
                callback(eventResponse)
            }
        }
    }
    
    
}
