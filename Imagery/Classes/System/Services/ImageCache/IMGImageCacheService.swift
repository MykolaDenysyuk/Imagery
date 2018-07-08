//
//  IMGImageCacheService.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

/// Responsible for fetching images and caching them by given URL
protocol IMGImageCacheService {
    
    /// Fetches thumbnail image first if it is not nil and returns it in onComplete closure
    /// Then fetches the main image and returns in onComplete as well
    /// Fetched image then cached using url as cache key
    /// If main image exists in cache it's returned in onComplete immediately (thumbnail not fetched in this case)
    ///
    /// - Parameters:
    ///   - url: main image path
    ///   - thumbnailImage: preview image path
    ///   - onComplete: completion closure
    /// - Returns: return object that allows to cancel fetching operation
    func getImage(from url: URL, thumbnailImage: URL?, onComplete: @escaping (UIImage?) -> Void) -> IMGCancelable
}
