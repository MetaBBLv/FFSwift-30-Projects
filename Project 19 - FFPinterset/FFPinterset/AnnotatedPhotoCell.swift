//
//  AnnotatedPhotoCell.swift
//  FFPinterset
//
//  Created by zhou on 2019/7/13.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var photo: FFPhoto? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                captionLabel.text = photo.caption
                commentLabel.text = photo.comment
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
}
