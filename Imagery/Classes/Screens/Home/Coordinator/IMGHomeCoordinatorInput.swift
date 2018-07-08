//
//  IMGHomeCoordinatorInput.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

protocol IMGHomeCoordinatorInput: IMGAlertsCoordinator {
    
    /// Open filter screen
    /// - Parameter callback: is called when new filter setting is applied
    ///                       with object that describes selected filter's values
    func showFilter(callback: (Any) -> Void) // todo
    /// Show screen with details for given item
    func showDetails(for itme: IMGContent.Item)
}
