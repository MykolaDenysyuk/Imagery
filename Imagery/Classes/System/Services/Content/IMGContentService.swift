//
//  IMGContentService.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation


typealias IMGContentCompletion = (IMGResult<IMGContent.Response, Error>) -> Void

protocol IMGContentService {
    func search(query: IMGContent.Query, onComplete: @escaping IMGContentCompletion) -> IMGCancelable?
}
