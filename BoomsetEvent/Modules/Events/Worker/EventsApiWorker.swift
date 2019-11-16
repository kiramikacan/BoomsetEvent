//
//  EventsApiWorker.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/16/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

//MARK: - Properties
class EventsApiWorker {
    let mApiService = ApiService()
    let mBaseUrl = Config.ApiBaseUrl
}

//MARK: - Protocol Methods
extension EventsApiWorker: EventsApiWorkerProtocol {
    
    func fetchEvents(callback: @escaping (ECallbackResultType) -> Void) {
        do {
            // Construct login endpoint
            let url = try mApiService.constructApiEndpoint(base: mBaseUrl, params: "events")
            let headers = try mApiService.constructHeader()
            
            
            print("url = \(url)")
            print("headers = \(headers)")
            
            mApiService.get(
                url: url,
                parameters: nil,
                headers: headers,
                converter: { (jsonData) -> Any? in
                    do {
                        let eventResponse = try JSONDecoder().decode(EventResponse.self, from: jsonData)
                        return eventResponse
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                    return nil
                },
                callback: callback)
        } catch {
            callback(ECallbackResultType.Failure(ApiErrorModel(type: EApiErrorType.InvalidParameters)))
        }
    }
    
}
