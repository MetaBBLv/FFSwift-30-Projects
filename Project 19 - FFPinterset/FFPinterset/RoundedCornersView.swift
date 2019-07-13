//
//  RoundedCornersView.swift
//  FFPinterset
//
//  Created by zhou on 2019/7/13.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornersView: UIView {

    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

}
