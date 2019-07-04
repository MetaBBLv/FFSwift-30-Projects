//
//  FFHomeViewController.swift
//  FFInterests
//
//  Created by zhou on 2019/7/4.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFHomeViewController: UIViewController {

    @IBOutlet weak var barkgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var interests = FFInterest.createInterests()
    
    fileprivate struct Storyboard {
        static let cellIdentifier = "Interest Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK : - UICollectionViewDataSource
extension FFHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.cellIdentifier, for: indexPath) as! FFInterestsCollectionViewCell
        cell.interest = interests[(indexPath as NSIndexPath).item]
        return cell
    }
}

//MARK: - UIScrollViewDelegate
extension FFHomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
        let roundeIndex = round(index)
        
        offset = CGPoint(x: roundeIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    }
}
