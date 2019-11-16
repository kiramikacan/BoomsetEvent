//
//  GuestsCacher.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties & Method
class GuestsCacher {
    
    private let keyGuestsJsonString = "BoomsetEvent_GuestsJsonString"
    
    func getForKey(with eventId: Int) -> String {
        let forKey = keyGuestsJsonString + "_\(eventId)"
        return forKey
    }
    
    private func setJsonString(jsonString: String, for eventId: Int) {
        let forKey = getForKey(with: eventId)
        let defaults = UserDefaults.standard
        defaults.set(jsonString, forKey: forKey)
    }
    
    private func getJsonString(for eventId: Int) -> String? {
        let forKey = getForKey(with: eventId)
        let defaults = UserDefaults.standard
        let jsonString: String? = defaults.object(forKey: forKey) as? String
        return jsonString
    }
}

//MARK: - Protocol Methods
extension GuestsCacher: GuestsCacherProtocol {
    
    func saveGuestsToTheCache(guestResponse: GuestResponse?, for eventId: Int) {
        DispatchQueue.global().async { [weak self] in
            //Encode to Json format
            if let encodedObject = try? JSONEncoder().encode(guestResponse), let encodedObjectJsonString = String(data: encodedObject, encoding: .utf8)
            {
                self?.setJsonString(jsonString: encodedObjectJsonString, for: eventId)
            }
        }
    }
    
    func loadGuestsFromTheCache(for eventId: Int, callback: @escaping (GuestResponse?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            var response: GuestResponse?
            if let jsonString = self?.getJsonString(for: eventId), let jsonData = jsonString.data(using: .utf8) {
                do
                {
                    response = try JSONDecoder().decode(GuestResponse.self, from: jsonData)
                } catch {
                    print("error while json decoding")
                }
            }
            
            DispatchQueue.main.async {
                callback(response)
            }
        }
    }
    
    
}
