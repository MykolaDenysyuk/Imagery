//
//  IMGDetailsInfoCell.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGDetailsInfoCell: UITableViewCell {

    // MARK: Vars
    
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var favoritesLabel: UILabel!
    @IBOutlet private weak var downloadsLabel: UILabel!
    @IBOutlet private weak var tags: UILabel!
    
    // MARK: Actions
    
    func setup(with data: IMGDetailsViewRowType.Details) {
        likesLabel.text = data.likes
        favoritesLabel.text = data.favorites
        downloadsLabel.text = data.downloads
        tags.text = data.tags
    }
}
