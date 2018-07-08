//
//  NetworkManagerTests.swift
//  ImageryTests
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import XCTest
@testable import Imagery

class NetworkManagerTests: XCTestCase {
    
    func testResponseHandlerAllNil() {
        let exp = expectation(description: #function)
        let handler = IMGNetworkManager.ResponseHandler()
        
        handler.handle(data: nil, response: nil, error: nil) { (result) in
            switch result {
            case .success:
                XCTFail("failure is expected")
            case .failure(let error):
                XCTAssert(!error.localizedDescription.isEmpty)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResponseHandlerError() {
        let exp = expectation(description: #function)
        let expectedError = IMGLocalizedError(localizedDescription: #function)
        let handler = IMGNetworkManager.ResponseHandler()
        
        handler.handle(data: nil, response: nil, error: expectedError) { (result) in
            switch result {
            case .success:
                XCTFail("failure is expected")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResponseHandlerSuccess() {
        let exp = expectation(description: #function)
        let expectedData = Data([1,2,3])
        let successCode = 42
        let response = HTTPURLResponse(url: URL(fileURLWithPath: #function),
                                       statusCode: successCode,
                                       httpVersion: nil,
                                       headerFields: nil)
        let handler = IMGNetworkManager.ResponseHandler(success: successCode)
        
        handler.handle(data: expectedData, response: response, error: nil) { (result) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedData)
                
            case .failure:
                XCTFail("success is expected")
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResponseHandlerEmptyData() {
        let exp = expectation(description: #function)
        let expectedData = Data()
        let successCode = 42
        let response = HTTPURLResponse(url: URL(fileURLWithPath: #function),
                                       statusCode: successCode,
                                       httpVersion: nil,
                                       headerFields: nil)
        let handler = IMGNetworkManager.ResponseHandler(success: successCode)
        
        handler.handle(data: expectedData, response: response, error: nil) { (result) in
            switch result {
            case .success:
                XCTFail("failure is expected")
                
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription,
                               IMGNetworkError.emptyData.localizedDescription)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResponseHandlerTooManyRequests() {
        let exp = expectation(description: #function)
        let expectedData = Data([1,2,3])
        let tooManyRequestsCode = 653
        let response = HTTPURLResponse(url: URL(fileURLWithPath: #function),
                                       statusCode: tooManyRequestsCode,
                                       httpVersion: nil,
                                       headerFields: nil)
        let handler = IMGNetworkManager.ResponseHandler(tooManyRequests: tooManyRequestsCode)
        
        handler.handle(data: expectedData, response: response, error: nil) { (result) in
            switch result {
            case .success:
                XCTFail("failure is expected")
                
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription,
                               IMGNetworkError.requestsLimit.localizedDescription)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResponseHandlerUnknownStatusCode() {
        let exp = expectation(description: #function)
        let expectedData = Data([1,2,3])
        let response = HTTPURLResponse(url: URL(fileURLWithPath: #function),
                                       statusCode: 123,
                                       httpVersion: nil,
                                       headerFields: nil)
        let handler = IMGNetworkManager.ResponseHandler()
        
        handler.handle(data: expectedData, response: response, error: nil) { (result) in
            switch result {
            case .success:
                XCTFail("failure is expected")
                
            case .failure(let error):
                XCTAssert(!error.localizedDescription.isEmpty)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
