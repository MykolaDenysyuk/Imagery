//
//  IMGFilterViewInterfaces.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

struct IMGFileCategoryItem {
    let name: String
    var value: String
}

protocol IMGFilterViewOutput: IMGListViewOutput where View == IMGListViewInput {
    /// cancel button action
    func cancelAction()
    /// save button action
    func applyAction()
}

