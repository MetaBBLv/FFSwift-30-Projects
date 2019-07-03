//
//  FFManagePageViewController.swift
//  FFPhotoScroll
//
//  Created by zhou on 2019/7/3.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFManagePageViewController: UIPageViewController {
    
    var photos = ["photo1", "photo2", "photo3", "photo4","photo5"]
    var currentIndex: Int!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let viewController = viewPhotoCommentController(index: currentIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
    }
    
    fileprivate func viewPhotoCommentController(index: Int) -> FFPhotoCommentViewController? {
        if let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "PhotoCommentViewController") as? FFPhotoCommentViewController
        {
            page.photoName = photos[index]
            page.photoIndex = index
            return page
        }
        
        return nil
    }
}

extension FFManagePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? FFPhotoCommentViewController {
            guard let index = viewController.photoIndex, index != 0 else {
                return nil
            }
            return viewPhotoCommentController(index: index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? FFPhotoCommentViewController {
            guard let index = viewController.photoIndex, index != photos.count - 1 else {
                return nil
            }
            return viewPhotoCommentController(index: index + 1)
        }
        return nil
    }
    
    // MARK: UIPageControl
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
    
}
