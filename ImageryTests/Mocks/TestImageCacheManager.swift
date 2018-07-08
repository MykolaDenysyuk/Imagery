//
//  TestImageCacheManager.swift
//  ImageryTests
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit
@testable import Imagery

class TestImageCacheManager: IMGImageCacheService {
    var image: UIImage?
    func getImage(from url: URL, thumbnailImage: URL?, onComplete: @escaping (UIImage?) -> Void) -> IMGCancelable {
        onComplete(image)
        return TestCancelable()
    }
}

extension TestImageCacheManager {
    class FetchersFactory: IMGImageCacheManager.FetchersFactory {
        
        var createdFetchers = [Fetcher]()
        
        override func createFetcher(url: URL, next: IMGImageCacheManager.ImageFetcher?) -> IMGImageCacheManager.ImageFetcher {
            let fetcher = Fetcher(url: url, next: next)
            createdFetchers.append(fetcher)
            return fetcher
        }
    }
    
    class Fetcher: IMGImageCacheManager.ImageFetcher {
        
        private(set) var isFetchStarted = false
        
        override func fetch(complete: @escaping (UIImage?) -> Void) {
            isFetchStarted = true
        }
    }
}
