//
//  FFProduct.swift
//  FFGoodsAndOldPhones
//
//  Created by zhou on 2019/6/14.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFProduct: NSObject {

    var name : String?
    var cellImage : String?
    var fullScreenImageView : String?
    
    init(name:String, cellImage:String, fullScreenImageView: String) {
        self.name = name
        self.cellImage = cellImage
        self.fullScreenImageView = fullScreenImageView
    }
}
