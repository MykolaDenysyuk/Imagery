//
//  XCTestCase+Extra.swift
//  ImageryTests
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import XCTest


extension XCTestCase {
    func loadData(from jsonFileName: String, complete: (Data) -> Void) {
        let data: Data? = {
            if let fileURL = Bundle(for: self.classForCoder).url(forResource: jsonFileName, withExtension: "json"),
                let data = try? Data(contentsOf: fileURL) {
                return data
            }
            return nil
        }()
        if let data = data {
            complete(data)
        }
        else {
            XCTFail("Can't load json file - \(jsonFileName)")
        }
    }
}

