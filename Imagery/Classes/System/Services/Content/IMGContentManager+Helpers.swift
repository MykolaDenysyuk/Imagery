//
//  IMGContentManager+Helpers.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

extension IMGContentManager {
    class RequestFactory {
        func createQueryParameters(apiKey: String, query: IMGContent.Query) -> [String: Any] {
            var parameters: [String: Any] = ["key": apiKey]
            if let search = query.search {
                parameters["q"] = search
            }
            if let pageSize = query.pageSize {
                parameters["per_page"] = pageSize
            }
            if let page = query.page {
                parameters["page"] = page
            }
            if let category = query.category {
                parameters["category"] = category
            }
            if let order = query.order {
                parameters["order"] = order
            }
            
            return parameters
        }
    }
    
    class ContentDataParser<T: Codable> {
        func parse(data: Data) -> IMGResult<T, Error> {
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                return .success(response)
            }
            catch {
                return .failure(error)
            }
        }
    }
    
    class ResponseHandler {
        let dataParser: ContentDataParser<IMGContent.Response>
        
        init(parser: ContentDataParser<IMGContent.Response> = ContentDataParser<IMGContent.Response>()) {
            self.dataParser = parser
        }
        
        func handle(response: IMGResult<Data, IMGNetworkError>) -> IMGResult<IMGContent.Response, Error> {
            switch response {
            case .success(let data):
                return dataParser.parse(data: data)
            case .failure(let error):
                return .failure(error)
            }
                
        }
    }
}
