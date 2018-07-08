//
//  IMGContentService.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

/// Responsible for fetching content from any images sharring provider
protocol IMGContentService {
    func search(query: IMGContent.Query, onComplete: @escaping IMGContentCompletion) -> IMGCancelable?
}
