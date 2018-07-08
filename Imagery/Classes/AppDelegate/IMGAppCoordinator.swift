//
//  IMGAppCoordinator.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

/// Main app's coordinator
/// It starts the views hierarchy
class IMGAppCoordinator {
    /// Create main window with a root controller
    func start() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootController = UINavigationController()
        window.rootViewController = rootController
        window.makeKeyAndVisible()
        
        let home = IMGHomeCoordinator()
        home.start(from: rootController, with: nil)
        
        rootController.navigationBar.titleTextAttributes = AppDelegate.appTitleAttributes
        
        return window
    }
}
