//
//  UIImage+FFDecompression.swift
//  FFPinterset
//
//  Created by zhou on 2019/7/12.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

extension UIImage {
    
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint.zero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage!
    }
}
