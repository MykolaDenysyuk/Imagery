//
//  IMGCoordinator.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit


/// Generic interface for Coordinators
protocol IMGCoordinator {
    associatedtype InputData
    
    /// Initial controller for currnet coordinator
    var rootController: UIViewController? { get }
    
    
    /// Create rootController using given data and present it from presenting controller
    ///
    /// - Parameters:
    ///   - from: controller that prensents rootController
    ///   - data: input data
    func start(from presenting: UIViewController, with data: InputData)
}
