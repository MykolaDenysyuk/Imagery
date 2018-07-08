//
//  IMGDetailsCoordinatorInput.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import Foundation

protocol IMGDetailsCoordinatorInput: IMGAlertsCoordinator {
    /// Shows activity controller with share options, where URL is a path to given page
    func showExport(url: URL)
    /// Open resource at given url in browser
    func openInBrowser(url: URL)
}
