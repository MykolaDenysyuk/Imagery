//
//  IMGLocalizedError.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

/// Concrete type for LocalizedError
struct IMGLocalizedError: LocalizedError {
    let localizedDescription: String
    var errorDescription: String? {
        return localizedDescription
    }
}
