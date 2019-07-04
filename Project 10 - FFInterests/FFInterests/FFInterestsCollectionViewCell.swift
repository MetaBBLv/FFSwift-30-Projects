//
//  FFInterestsCollectionViewCell.swift
//  FFInterests
//
//  Created by zhou on 2019/7/4.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFInterestsCollectionViewCell: UICollectionViewCell {
    //MARK : - IBOutlets
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK : - public API
    var interest: FFInterest! {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        titleLabel.text = interest.title
        featuredImageView.image = interest.featuredImage
    }
    
    //MARK: - refactor layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
}
