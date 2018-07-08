//
//  IMGLoadingIndicator.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

/// General interface for any type that can indicate its loading state
protocol IMGLoadingIndicator: class {
    
    /// if true loading indicator is shown
    var isLoading: Bool { get set }
}
