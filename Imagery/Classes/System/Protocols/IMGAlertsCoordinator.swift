//
//  IMGAlertsCoordinator.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol IMGAlertsCoordinator {
    /// shows alert controller with given title and message
    func showAlert(title: String, message: String)
}

extension IMGAlertsCoordinator where Self: IMGCoordinator {
    func showAlert(title: String, message: String) {
        guard let root = rootController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        root.present(alert, animated: true, completion: nil)
    }
}
