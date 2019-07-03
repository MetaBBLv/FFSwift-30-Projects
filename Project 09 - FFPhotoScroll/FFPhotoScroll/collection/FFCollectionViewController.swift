//
//  FFCollectionViewController.swift
//  FFPhotoScroll
//
//  Created by zhou on 2019/7/3.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FFCollectionViewController: UICollectionViewController {
    
    fileprivate let reuseIdentifier = "PhotoCell"
    fileprivate let thumbnailSize: CGFloat = 70.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let zoomedPhotoViewController = segue.destination as? FFZoomedPhotoViewController {
            zoomedPhotoViewController.photoName = "photo\(indexPath.row + 1)"
        }
        
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let photoCommentViewController = segue.destination as? FFPhotoCommentViewController {
            photoCommentViewController.photoName = "photo\(indexPath.row + 1)"
        }
        
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let managePageViewController = segue.destination as? FFManagePageViewController {
            managePageViewController.photos = photos
            managePageViewController.currentIndex = indexPath.row
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
}

// MARK: UICollectionViewDataSource
extension FFCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FFPhotoCollectionViewCell
        let fullSizeImage = UIImage(named: photos[indexPath.row])
        cell.imageView.image = fullSizeImage?.thumbnailOfSize(thumbnailSize)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FFCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: thumbnailSize, height: thumbnailSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

