//
//  FFUIImage.swift
//  FFPhotoScroll
//
//  Created by zhou on 2019/7/3.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

extension UIImage {
    func thumbnailOfSize(_ size: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
        let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumbnail!
    }
}
