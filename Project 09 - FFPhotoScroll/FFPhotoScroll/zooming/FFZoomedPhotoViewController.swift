//
//  FFZoomedPhotoViewController.swift
//  FFPhotoScroll
//
//  Created by zhou on 2019/7/3.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFZoomedPhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    var photoName: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: photoName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScale(forSize: view.bounds.size)
    }
    
    fileprivate func updateConstraints(forSize size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    fileprivate func updateMinZoomScale(forSize size:CGSize) {
        let widthSacel = size.width / imageView.bounds.width
        let heightSacel = size.height / imageView.bounds.height
        let minScale = min(widthSacel, heightSacel)
        
        scrollView.minimumZoomScale = minScale
        
        scrollView.zoomScale = minScale
    }
}

extension FFZoomedPhotoViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraints(forSize: view.bounds.size)
    }
}
