//
//  TestContentManager.swift
//  ImageryTests
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation
@testable import Imagery

class TestContentManager: IMGContentService {
    func search(query: IMGContent.Query, onComplete: @escaping IMGContentCompletion) -> IMGCancelable? {
        return nil
    }
}

extension TestContentManager {
    class DataParser: IMGContentManager.ContentDataParser<IMGContent.Response> {
        var result = IMGResult<IMGContent.Response, Error>.failure(IMGLocalizedError(localizedDescription: "none"))
        override func parse(data: Data) -> IMGResult<IMGContent.Response, Error> {
            return result
        }
    }
}
