//
//  IMGResult.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

/// Generic container for result object
enum IMGResult<SuccessT, ErrorT> {
    case success(SuccessT)
    case failure(ErrorT)
}
