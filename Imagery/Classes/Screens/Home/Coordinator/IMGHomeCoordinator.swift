//
//  IMGHomeCoordinator.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

/// Entry point of Home module
class IMGHomeCoordinator: IMGCoordinator, IMGHomeCoordinatorInput {
    
    weak var rootController: UIViewController?
    
    func start(from presenting: UIViewController, with data: Any?) {
        let presenter = IMGHomePresenter(coordinator: self)
        let controller = IMGHomeViewController(datasource: presenter,
                                               eventsHandler: presenter)
        if let navigationController = presenting as? UINavigationController {
            navigationController.viewControllers = [controller]
        }
        else {
            let container = UINavigationController(rootViewController: controller)
            presenting.show(container, sender: nil)
        }
    }
    
    func showFilter(callback: (Any) -> Void) {
        // todo
    }
    
    func showDetails(for itme: IMGContent.Item) {
        // todo
    }
}
