//
//  FFAlbumView.swift
//  FFBlueLibarySwift
//
//  Created by zhou on 2019/7/10.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFAlbumView: UIView {

    private var coverImageView: UIImageView!
    private var indicatorView: UIActivityIndicatorView!
    private var valueObservation: NSKeyValueObservation!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInti()
    }
    
    init(frame: CGRect, coverUrl: String) {
        super.init(frame: frame)
        commonInti()
        
        NotificationCenter.default.post(name: .BLDownloadImage, object: self, userInfo: ["imageView": coverImageView ?? UIImage(), "coverUrl": coverUrl])
    }

    private func commonInti() {
        // setup the background
        backgroundColor = .black
        
        // Create the indicator View
        coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coverImageView)
        
        // Create the indicator View
        indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.style = .whiteLarge
        indicatorView.startAnimating()
        addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        valueObservation = coverImageView.observe(\.image, options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.indicatorView.stopAnimating()
            }
        }
    }
    
    func heightAlbum(_ didHeightView: Bool) {
        if didHeightView == true {
            backgroundColor = .white
        } else {
            backgroundColor = .black
        }
    }
}

extension Notification.Name {
    static let BLDownloadImage = Notification.Name(downloadImageNotification)
}
