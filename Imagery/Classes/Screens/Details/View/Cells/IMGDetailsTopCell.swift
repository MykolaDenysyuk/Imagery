//
//  IMGDetailsTopCell.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGDetailsTopCell: UITableViewCell {

    // MARK: Vars
    
    @IBOutlet private weak var blurredMainImageView: UIImageView!
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.masksToBounds = true
            userImageView.layer.cornerRadius = userImageView.frame.width/2
        }
    }
    @IBOutlet private weak var userName: UILabel!
    private var mainImageFetch: IMGCancelable?
    private var userImageFetch: IMGCancelable?
    
    // MARK: Actions
 
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        userImageView.image = nil
        mainImageFetch?.cancel()
        userImageFetch?.cancel()
    }
    
    func setup(with data: IMGDetailsViewRowType.Header, imageCache: IMGImageCacheService) {
        
        if let mainImageUrl = data.imagePath {
            mainImageFetch =
                imageCache.getImage(from: mainImageUrl, thumbnailImage: data.previewImagePath) {
                    [weak self] (image) in
                    self?.blurredMainImageView.image = image
                    self?.mainImageView.fadeSwitch(new: image)
            }
        }
        else {
            mainImageView.image = nil
        }
        
        if let userImageUrl = data.userImageUrl {
            userImageView.isHidden = false
            userImageFetch =
            imageCache.getImage(from: userImageUrl, thumbnailImage: nil) {
                [weak self] (image) in
                self?.userImageView.fadeSwitch(new: image)
            }
        }
        else {
            userImageView.isHidden = true
        }
        userName.text = data.user
    }
}
