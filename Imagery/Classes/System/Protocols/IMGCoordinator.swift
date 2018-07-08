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

extension IMGCoordinator {
    /// Returns view controller if it exists, otherwise throws an exception.
    /// This getter is used in places where absence of rootControlle is critical
    /// there is no other way to continue running the app
    func rootControllerOrFail() -> UIViewController {
        guard let root = rootController else { fatalError("root controller required!") }
        return root
    }
}
