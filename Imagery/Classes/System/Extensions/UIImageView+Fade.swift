//
//  UIImageView+Fade.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

extension UIImageView {
    /// Replaces current image with the given one using fade animation
    func fadeSwitch(new image: UIImage?) {
        UIView.transition(with: self,
                          duration: 0.15,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.image = image
        }, completion: nil)
    }
}
