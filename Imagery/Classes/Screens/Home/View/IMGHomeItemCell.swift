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
    }
    
    func setup(item: IMGHomeViewDisplayItem, imagesCache: IMGImageCacheService) {
        currentImageLoadTask =
        imagesCache.getImage(from: item.imageURL, thumbnailImage: nil) { (image) in
            DispatchQueue.main.async {
                UIView.transition(with: self.imageView,
                                  duration: 0.15,
                                  options: [.transitionCrossDissolve],
                                  animations: {
                                    self.imageView.image = image
                }, completion: nil)
            }
        }
    }
}
