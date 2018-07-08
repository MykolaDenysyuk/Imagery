//
//  IMGImageCacheManager.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGImageCacheManager: IMGImageCacheService {
    
    let fetchersFactory: FetchersFactory
    
    init(factory: FetchersFactory = FetchersFactory()) {
        self.fetchersFactory = factory
    }
    
    func getImage(from url: URL, thumbnailImage: URL?, onComplete:@escaping (UIImage?) -> Void) -> IMGCancelable {
        // main image fetched
        var fetcher = fetchersFactory.createFetcher(url: url)
        if let thumbnail = thumbnailImage {
            // thumbnail fetcher. Fetch thumbnail first
            fetcher = fetchersFactory.createFetcher(url: thumbnail, next: fetcher)
        }
        fetcher.fetch(complete: onComplete)
        return fetcher
    }
    
}
