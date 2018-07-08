//
//  ImageCacheManagerTests.swift
//  ImageryTests
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import XCTest
@testable import Imagery

class ImageCacheManagerTests: XCTestCase {
    
    func testGetImageMain() {
        let factory = TestImageCacheManager.FetchersFactory()
        let service = IMGImageCacheManager(factory: factory)
        let url = URL(string: "https://test.com")!
        let _ = service.getImage(from: url, thumbnailImage: nil, onComplete: {_ in})
        
        XCTAssert(factory.createdFetchers.count == 1,
                  "1 fetcher expected to be created to load main image")
        if let fetcher = factory.createdFetchers.first {
            XCTAssert(fetcher.isFetchStarted)
            XCTAssertEqual(fetcher.url, url)
            XCTAssertNil(fetcher.next)
        }
        else {
            XCTFail()
        }
    }
    
    func testGetImageMainAndThumbnail() {
        let factory = TestImageCacheManager.FetchersFactory()
        let service = IMGImageCacheManager(factory: factory)
        let urlMain = URL(string: "https://test.main.com")!
        let urlThumbnail = URL(string: "https://test.thumbnail.com")!
        let _ = service.getImage(from: urlMain, thumbnailImage: urlThumbnail, onComplete: {_ in})
        
        XCTAssert(factory.createdFetchers.count == 2,
                  "2 fetchers are expected to be created to load both thumbnail and main image")
        if let main = factory.createdFetchers.first, let thumbnail = factory.createdFetchers.last {
            XCTAssert(!main.isFetchStarted, "main fetcher should be started after thumbnail is completed")
            XCTAssertEqual(main.url, urlMain)
            XCTAssertNil(main.next, "main fetcher is the last in the chain")
            
            XCTAssert(thumbnail.isFetchStarted, "thumbnail fetcher should start first")
            XCTAssertEqual(thumbnail.url, urlThumbnail)
            XCTAssertNotNil(thumbnail.next, "main fetcher should be chainer after thumbnail")
            XCTAssertEqual(thumbnail.next?.url, main.url)
        }
        else {
            XCTFail()
        }
    }

}
