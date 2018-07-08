//
//  UIFont+Extra.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

extension UIFont {
    static func imgRegularText(size: CGFloat) -> UIFont {
        return UIFont(name: "Noteworthy-Light", size: size) ?? .systemFont(ofSize: size)
    }
    static func imgBoldText(size: CGFloat) -> UIFont {
        return UIFont(name: "Noteworthy-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    
}
