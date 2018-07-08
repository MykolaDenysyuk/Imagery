//
//  ContentManagerTests.swift
//  ImageryTests
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import XCTest
@testable import Imagery

class ContentManagerTests: XCTestCase {
    
    func testDataParserContentItem() {
        parse(fileName: "ContentItem") { (item: IMGContent.Item) in
            XCTAssertEqual(item.id, 3521472)
            XCTAssertEqual(item.pageURL, "https://pixabay.com/en/landscape-nature-cornfield-grain-3521472/")
            XCTAssertEqual(item.type, "photo")
            XCTAssertEqual(item.tags, "landscape, nature, cornfield")
            XCTAssertEqual(item.previewURL, "https://cdn.pixabay.com/photo/2018/07/07/01/37/landscape-3521472_150.jpg")
            XCTAssertEqual(item.largeImageURL, "https://pixabay.com/get/ea30b30e2cf3033ed1584d05fb1d4f92ea75e7d010ac104496f1c17ca7ecb1b0_1280.jpg")
            XCTAssertEqual(item.userImageURL, "https://cdn.pixabay.com/user/2018/03/03/02-42-33-129_250x250.png")
            XCTAssertEqual(item.user, "analogicus")
        }
    }
    
    func testDataParserContentResponse() {
        parse(fileName: "ContentResponse") { (item: IMGContent.Response) in
            XCTAssertEqual(item.total, 818785)
            XCTAssert(item.hits.count == 1)
        }
    }
    
    func parse<T: Codable>(fileName: String, complete: (T) -> Void) {
        let parser = IMGContentManager.ContentDataParser<T>()
        loadData(from: fileName) {
            let result = parser.parse(data: $0)
            switch result {
            case .success(let item):
                complete(item)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testResponseHandlerParsedSuccess() {
        let parser = TestContentManager.DataParser()
        let expected = IMGContent.Response(total: 42, hits: [])
        parser.result = .success(expected)
        let handler = IMGContentManager.ResponseHandler(parser: parser)
        
        let result = handler.handle(response: .success(Data()))
        
        switch result {
        case .success(let data):
            XCTAssertEqual(data.total, expected.total)
        default:
            XCTFail("success is expected")
        }
    }
    
    func testResponseHandlerParsedFailure() {
        let parser = TestContentManager.DataParser()
        let expected = IMGLocalizedError(localizedDescription: #function)
        parser.result = .failure(expected)
        let handler = IMGContentManager.ResponseHandler(parser: parser)
        
        let result = handler.handle(response: .success(Data()))
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, expected.localizedDescription)
        default:
            XCTFail("failure is expected")
        }
    }
}
