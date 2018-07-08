//
//  URLComponents+Query.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

extension URLComponents {
    /// Initialize with a URL string and map ginve query dictionary into queryItems
    init?(string: String, query: [String: Any]) {
        self.init(string: string)
        self.queryItems = query.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}
