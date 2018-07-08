//
//  IMGHomeItemCell.swift
//  Imagery
//
//  Created by Mykola Denysyuk on 7/8/18.
//  Copyright © 2018 Mykola Denysyuk. All rights reserved.
//

import UIKit

class IMGHomeItemCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    private var currentImageLoadTask: IMGCancelable?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentImageLoadTask?.cancel()
        imageView.image = nil
    }
    
    func setup(item: IMGHomeViewDisplayItem, imagesCache: IMGImageCacheService) {
        currentImageLoadTask =
        imagesCache.getImage(from: item.imageURL, thumbnailImage: nil) {
            [weak self] (image) in
            self?.imageView.fadeSwitch(new: image)
        }
    }
}
