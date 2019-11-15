//
//  LoginViewInteractor.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation

class LoginViewInteractor {
    
    let mApiService = ApiService()
    
    let mBaseUrl = "https://www.boomset.com"
    
    func loginWithCredentials(username: String, password: String, callback:@escaping (ECallbackResultType) -> Void ) {
            
            do {
                // Construct login endpoint
                let url = try mApiService.constructApiEndpoint(base: mBaseUrl, params: "apps", "api", "auth")
                let headers = try mApiService.constructHeader()
                
                let parameters: [String : Any] = [
                    "username": username,
                    "password": password,
                ]
                
                print("url = \(url)")
                print("headers = \(headers)")
                print("parameters = \(parameters)")
                
                mApiService.create(
                    url,
                    parameters: parameters,
                    headers: headers,
                    converter: { [weak self] (jsonData) -> Any? in
                        self?.userConverterFrom(jsonData)
                    },
                    callback: callback)
            } catch {
                callback(ECallbackResultType.Failure(ApiErrorModel(type: EApiErrorType.InvalidParameters)))
            }
        }
    
    func userConverterFrom(_ jsonData: Data) -> Any? {
        do {
            let user = try JSONDecoder().decode(User.self, from: jsonData)
            return user
        } catch {
            print("Error while json decoding: \(error.localizedDescription)")
            return nil
        }
    }
    
}
