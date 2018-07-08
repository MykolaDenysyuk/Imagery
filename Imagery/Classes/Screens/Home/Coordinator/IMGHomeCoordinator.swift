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
        rootController = controller
    }
    
    func showFilter(currentQuery: IMGContent.Query, callback: @escaping (IMGContent.Query) -> Void) {
        let filter = IMGFilterCoordinator()
        filter.start(from: rootControllerOrFail(), with: IMGFilterCoordinatorData(query: currentQuery, callback: callback))
    }
    
    func showDetails(for item: IMGContent.Item) {
        let details = IMGDetailsCoordinator()
        details.start(from: rootControllerOrFail(), with: item)
    }
}
