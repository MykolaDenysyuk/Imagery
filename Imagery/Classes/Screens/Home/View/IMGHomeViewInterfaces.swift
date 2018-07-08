//
//  IMGHomeViewInterfaces.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

struct IMGHomeViewDisplayItem {
    let imageURL: URL
}

protocol IMGHomeViewDatasource: IMGListViewDatasource where Element == IMGHomeViewDisplayItem {
    var imagesCache: IMGImageCacheService { get }
}

protocol IMGHomeViewOutput: IMGListViewOutput where View == IMGListViewInput & IMGLoadingIndicator {
    /// Called when user tap on filter button
    func viewDidTapFilter(_ view: View)
    
    /// called whenever user hits search button
    func view(_ view: View, didSearch text: String?)
}
