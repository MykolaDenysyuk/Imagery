//
//  IMGNetworkService+DataModels.swift
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
