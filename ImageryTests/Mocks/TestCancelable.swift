//
//  TestCancelable.swift
//  ImageryTests
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation
@testable import Imagery

final class TestCancelable: IMGCancelable {
    
    private(set) var isCanceled = false
    
    func cancel() {
        isCanceled = true
    }
}
