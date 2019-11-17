//
//  ApiService.swift
//  BoomsetEvent
//
//  Created by dev krm on 11/15/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    
    let dispatchQueueLabel = "com.whatsaround.app.response-queue"
    
    /**
     This function constructs an api endpoint with the given parameters
     - parameters:
     - base: Base url
     - params: url segments for endpoint construction
     - returns: API Endpoint
     */
    func constructApiEndpoint(base: String, params: String...) throws -> String {
        let url: String = try getApiEndpointUrl(base: base, params: params)
        
        return url
    }
    
    func getApiEndpointUrl(base: String, params: [String]) throws -> String {
        var url: String = base.hasSuffix("/") ? String(base[..<base.index(before: base.endIndex)]) : base
        
        for param in params {
            guard !param.isEmpty else {
                throw EApiErrorType.InvalidParameters
            }
            
            let trimmed = param.trimmingCharacters(in: .whitespacesAndNewlines)
            let pure = trimmed.replacingOccurrences(of: "/", with: "")
            
            url = "\(url)/\(pure)"
        }
        
        return url
    }
    
    /**
     This function constructs an api endpoint with the given parameters
     - parameters:
     - base: Base url
     - params: url segments for endpoint construction
     - queries: url query parameters for endpoint construction (optional)
     - returns: API Endpoint
     */
    func constructApiEndpoint(base: String, params: String..., queries: [String: String?]) throws -> String {
        var url: String = try getApiEndpointUrl(base: base, params: params)
        
        if queries.count > 0 {
            url = "\(url)?"
            for (key, value) in queries {
                let newValue = value ?? ""
                url = "\(url)\(key)=\(newValue)&"
            }
            url = String(url[..<url.index(before: url.endIndex)]) // remove last & character
        }
        
        return url
    }
    
    /**
     This method constructs HTTP header to consume the API
     - returns: HTTP header as key-value pairs
     */
    func constructHeader() throws -> [String: String] {
        var headers = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ] // Expect JSON from API
        
        // Passed user token in header for all requests if user us authenticated
        if let token = UserService.shared.getUserToken(), token.isEmpty == false {
            headers["Authorization"] = "Token \(token)"
        }
        
        return headers
    }
    
    func ApiErrorModelFromJson(resultValue: Any?, errorType: EApiErrorType) -> ApiErrorModel {
        let model: ApiErrorModel = ApiErrorModel(type: errorType)
        if let value = resultValue as Any? {
            print(value)
            let json = JSON(value)
            print(json)
            model.code = json["errorCode"].string == nil ? "" : json["errorCode"].stringValue
            model.message = json["message"].string == nil ? "" : json["message"].stringValue
        }
        return model
    }
    
    /**
     This method is responsible for handling alamofire response
     - parameters:
     - response: Response data which is coming from api
     - converter: Data model converter for fetched data
     - callback: The callback handler to provide the result of the fetched data
     */
    func handle(response: DataResponse<Any>, converter: ((Data) -> Any)?, callback: @escaping (ECallbackResultType) -> Void)  {
        // Get the status code of response
        if (response.response != nil) {
            print(response.result.value ?? "")
            let status = response.response!.statusCode;
            switch status {
            case EHttpStatusCode.OK.rawValue:
                var model: Any? = nil
                // Get the response body
                if let data = response.data, let converter = converter {
                    print(data)
                    model = converter(data)
                }
                // call callback with no error
                DispatchQueue.main.async {
                    callback(ECallbackResultType.Success(model))
                }
            case EHttpStatusCode.INVALID_CREDENTIAL.rawValue:
                // Invalid credentials
                DispatchQueue.main.async { [weak self] in
                    callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.InvalidCredentials))!))
                }
            case EHttpStatusCode.CONFLICT.rawValue:
                // User already exist
                DispatchQueue.main.async { [weak self] in
                    callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.AlreadyExist))!))
                }
            case EHttpStatusCode.NOT_FOUND.rawValue:
                // The email does not exist
                DispatchQueue.main.async { [weak self] in
                    callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.NotExist))!))
                }
            case EHttpStatusCode.BAD_REQUEST.rawValue:
                // Invalid parameters
                DispatchQueue.main.async { [weak self] in
                    callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.InvalidParameters))!))
                }
            case EHttpStatusCode.UNPROCESSABLE_ENTITY.rawValue:
                // Invalid entities
                DispatchQueue.main.async { [weak self] in
                    callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.InvalidEntities))!))
                }
            case EHttpStatusCode.FORBIDDEN.rawValue:
                // Content forbidden
                DispatchQueue.main.async { [weak self] in
                    callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.Forbidden))!))
                }
            default:
                DispatchQueue.main.async { [weak self] in
                    callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.UnknownError))!))
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                callback(ECallbackResultType.Failure((self?.ApiErrorModelFromJson(resultValue: response.result.value, errorType: EApiErrorType.APIEndpointNotAvailable))!))
            }
        }
    }
    
    /**
     This method sends a GET request to given url in order to fetch data
     - parameters:
     - url: API Endpoint
     - headers: Required HTTP header
     - callback: The callback handler to provide the result of the fetched data
     */
    func get(url: String, parameters: [String : Any]?, headers: [String : String]?, converter: ((Data) -> Any)?, callback: @escaping (ECallbackResultType) -> Void) {
        // Send the GET request
        
        let queue = DispatchQueue(label: dispatchQueueLabel, qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON(queue: queue) { [weak self] response in
            self?.handle(response: response, converter: converter, callback: callback)
        }
    }
    
    /**
     This method sends a POST request to given url in order to create data
     - parameters:
     - url: API endpoint
     - parameters: The data to be created
     - headers: Required HTTP header
     - callback: The callback handler to provide the result of the create operation
     */
    func create(_ url: String, parameters: [String : Any]?, headers: [String : String]?, converter: ((Data) -> Any)?, callback: @escaping (ECallbackResultType) -> Void) {
        // Send the POST request
        
        let queue = DispatchQueue(label: dispatchQueueLabel, qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(queue: queue) { [weak self] response in
                self?.handle(response: response, converter: converter, callback: callback)
        }
    }
    
    /**
     This method sends a PUT request to given url in order to update data
     - parameters:
     - url: API endpoint
     - parameters: The data to be updated
     - headers: Required HTTP header
     - callback: The callback handler to provide the result of the update operation
     */
    func update(url: String, parameters: [String : Any]?, headers: [String : String]?, callback: @escaping (ECallbackResultType) -> Void) {
        // Send the POST request
        
        let queue = DispatchQueue(label: dispatchQueueLabel, qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(queue: queue) { [weak self] response in
                self?.handle(response: response, converter: nil, callback: callback)
        }
    }
    
    /**
     This method sends a DELETE request to given url in order to update data
     - parameters:
     - url: API endpoint
     - parameters: The data to be deleted
     - headers: Required HTTP header
     - callback: The callback handler to provide the result of the update operation
     */
    func delete(url: String, parameters: [String : Any]?, headers: [String : String]?, callback: @escaping (ECallbackResultType) -> Void) {
        // Send the POST request
        
        let queue = DispatchQueue(label: dispatchQueueLabel, qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(queue: queue) { [weak self] response in
                self?.handle(response: response, converter: nil, callback: callback)
        }
    }
    
    func post(with request: URLRequest, converter: ((Data) -> Any)?, callback: @escaping (ECallbackResultType) -> Void) {
        // Send the POST request
        
        let queue = DispatchQueue(label: dispatchQueueLabel, qos: .utility, attributes: [.concurrent])
        
        Alamofire.request(request)
           .responseJSON(queue: queue) { [weak self] response in
                // do whatever you want here
                self?.handle(response: response, converter: converter, callback: callback)
        }
        
    }
    
}
