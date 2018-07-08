//
//  IMGImageCacheManager+Helpers.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit
import Kingfisher


extension RetrieveImageTask: IMGCancelable {}

extension IMGImageCacheManager {
    
    class FetchersFactory {
        func createFetcher(url: URL, next: ImageFetcher? = nil) -> ImageFetcher {
            return ImageFetcher(url: url, next: next)
        }
    }
    
    /// Seek the image in memory and disk first.
    /// If not found, it will download the image at url and cache it
    /// After complete, starts next fetcher if one is chained
    class ImageFetcher: IMGCancelable {
        
        // MARK: Vars
        
        private let cache = KingfisherManager.shared.cache
        private var currentTask: IMGCancelable?
        let url: URL
        /// The fetch to be performed after current is completed
        let next: ImageFetcher?
        
        // MARK: Initializer
        
        init(url: URL, next: ImageFetcher? = nil) {
            self.url = url
            self.next = next
        }
        
        // MARK: Actions
        
        func fetch(complete: @escaping (UIImage?) -> Void) {
            currentTask
                = KingfisherManager.shared.retrieveImage(with: url,
                                                         options: [.cacheMemoryOnly],
                                                         progressBlock: nil) {
                                                            [weak self] (img, _, _, _) in
                                                            complete(img)
                                                            self?.doNext(complete: complete)
            }
        }
        
        private func doNext(complete: @escaping (UIImage?) -> Void) {
            if let next = next {
                currentTask = next
                next.fetch(complete: complete)
            }
        }
        
        func cancel() {
            currentTask?.cancel()
        }
    }
}
