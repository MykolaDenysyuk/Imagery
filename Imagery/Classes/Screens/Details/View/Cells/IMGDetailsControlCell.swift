//
//  IMGDetailsControlCell.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGDetailsControlCell: UITableViewCell {

    @IBOutlet private weak var button: UILabel!
    
    func setup(with title: String) {
        button.text = title
    }
    
}
