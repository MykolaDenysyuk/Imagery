//
//  IMGContentService+DataModels.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

/// Namespace for content service's data models
enum IMGContent {
    /// Parameters for search query
    struct Query {
        let search: String?
        let pageSize: Int?
        let page: Int?
        let category: String?
        let order: String?
        
        static let `default` = Query(search: nil, pageSize: nil, page: nil, category: nil, order: nil)
    }
    
    struct Item: Codable {
        let id: Int
        let pageURL: String
        let type: String
        let tags: String
        let previewURL: String
        let largeImageURL: String
        let views: Int
        let downloads: Int
        let favorites: Int
        let likes: Int
        let user: String
        let userImageURL: String
    }
    
    /// Response result
    struct Response: Codable {
        let total: Int
        let hits: [Item]
    }
}
