//
//  IMGHomeLoadingOverlay.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit


/// An overlay view to dimm content view durring loading proccess
class IMGHomeLoadingOverlay: UIView, IMGLoadingIndicator {

    private let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                indicator.startAnimating()
            }
            else {
                indicator.stopAnimating()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = UIColor(white: 0.9, alpha: 0.2)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        [indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
         indicator.centerYAnchor.constraint(equalTo: centerYAnchor)]
            .forEach{ $0.isActive = true }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
