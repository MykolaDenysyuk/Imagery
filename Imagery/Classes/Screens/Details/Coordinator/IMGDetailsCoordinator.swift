//
//  IMGDetailsCoordinator.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

/// Entry point for Details module
class IMGDetailsCoordinator: IMGCoordinator, IMGDetailsCoordinatorInput {
    
    // MARK: Vars
    
    weak var rootController: UIViewController?
    
    // MARK: Actions
    
    func start(from presenting: UIViewController, with data: IMGContent.Item) {
        let presenter = IMGDetailsPresenter(coordinator: self,
                                            details: data)
        let controller = IMGDetailsViewController(datasource: presenter,
                                                  eventsHandler: presenter)
        presenting.show(controller, sender: nil)
        rootController = controller
    }

    func showExport(url: URL) {
        let share = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        rootControllerOrFail().present(share, animated: true, completion: nil)
    }
    
    func openInBrowser(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
