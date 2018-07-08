//
//  IMGCancelable.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

/// Any type that conform to this protocol should be able to cancel it's current task
protocol IMGCancelable {
    /// object stops doing whatever it does
    func cancel()
}
