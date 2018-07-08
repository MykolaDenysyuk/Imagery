//
//  IMGDetailsViewInterfaces.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

enum IMGDetailsViewRowType {
    
    struct Header {
        let previewImagePath: URL?
        let imagePath: URL?
        let userImageUrl: URL?
        let user: String
    }
    /// The top part of details screen
    case header(Header)
    
    struct Details {
        let likes: String
        let favorites: String
        let downloads: String
        let tags: String
    }
    
    /// Middle part, contains short data about image
    case details(Details)
    
    /// The bottom part. Contains controls with given title
    case action(String)
}


protocol IMGDetailsViewDatasource: IMGListViewDatasource where Element == IMGDetailsViewRowType {
    /// Screen title
    var title: String { get }
    
    var imagesCache: IMGImageCacheService { get }
}

protocol IMGDetailsViewOutput: IMGListViewOutput where View == IMGListViewInput {
    /// Called when user tap share button
    func viewDidTapShare(_ view: View)
}
