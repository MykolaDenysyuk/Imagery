//
//  IMGNetworkService.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

enum IMGNetworkError: LocalizedError {
    case unknown(Error)
    /// By default up to 5,000 requests can be made per hour
    case requestsLimit
    /// when request passed successfully but response data is empty
    case emptyData
    
    var errorDescription: String? {
        switch self {
        case .unknown(let error):
            return error.localizedDescription
        case .requestsLimit:
            return "Too Many Requests"
        case .emptyData:
            return "Empty data"
        }
    }
}
typealias IMGNetworkCompletion = (IMGResult<Data, IMGNetworkError>) -> Void

/// Encapsulates network related tasks
protocol IMGNetworkService {
    
    /// Executes given request and provides result on complete
    ///
    /// - Parameters:
    ///   - request: request to execute
    ///   - onComplete: closure is called when request is completed
    /// - Returns: object that can be canceled to cancel request execution
    func execute(request: URLRequest,
                 onComplete: @escaping IMGNetworkCompletion) -> IMGCancelable
}

extension IMGNetworkService {
    
    /// Executed GET request build using given parameters
    ///
    /// - Parameters:
    ///   - uri: request url
    ///   - parameters: parameters to map into request query
    ///   - onComplete: closure is called when request is completed
    /// - Returns: object that can be canceled to cancel request execution
    func get(from uri: String,
             parameters: [String: Any],
             onComplete: @escaping IMGNetworkCompletion) -> IMGCancelable? {
        
        guard
            let components = URLComponents(string: uri, query: parameters),
            let url = components.url
            else {
                let errMsg = "Can't make request with current uri: \(uri)"
                onComplete(.failure(.unknown(IMGLocalizedError(localizedDescription: errMsg))))
                return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return execute(request: request, onComplete: onComplete)
    }
    
}
