//
//  IMGNetworkManager.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

extension URLSessionTask: IMGCancelable {}

/// Concrete network service type
struct IMGNetworkManager: IMGNetworkService {

    let responseHandler = ResponseHandler()
    
    func execute(request: URLRequest, onComplete: @escaping IMGNetworkCompletion) -> IMGCancelable {
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            self.responseHandler.handle(data: $0, response: $1, error: $2, complete: onComplete)
        }
        task.resume()
        return task
    }
}

extension IMGNetworkManager {
    /// Handles response of NSURLSessionDataTask
    class ResponseHandler {
        
        // MARK: Vars
        
        let successCode: Int
        let tooManyRequestsCode: Int
        
        
        // MARK: Initializer
        
        init(success: Int = 200, tooManyRequests: Int = 429) {
            self.successCode = success
            self.tooManyRequestsCode = tooManyRequests
        }
        
        /// Pass specific result object into complete closure depending on given parameters
        ///
        /// - Parameters:
        ///   - data: possible response data
        ///   - response: possible response object. expected to be HTTPURLResponse
        ///   - error: possible error
        ///   - complete: closure to be called on complete
        func handle(data: Data?, response: URLResponse?, error: Error?, complete: @escaping IMGNetworkCompletion) {
            
            func unknown() {
                complete(.failure(.unknown(IMGLocalizedError(localizedDescription: "Unknown error"))))
            }
            
            if let error = error {
                complete(.failure(.unknown(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case successCode:
                    if let data = data, data.count > 0 {
                        complete(.success(data))
                    }
                    else {
                        complete(.failure(.emptyData))
                    }
                case tooManyRequestsCode:
                    complete(.failure(.requestsLimit))
                default:
                    unknown()
                }
                
            }
            else {
                unknown()
            }
        }
    }
}


