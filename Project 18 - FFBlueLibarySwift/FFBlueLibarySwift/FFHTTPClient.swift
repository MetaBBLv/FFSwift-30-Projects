//
//  FFHTTPClient.swift
//  FFBlueLibarySwift
//
//  Created by zhou on 2019/7/10.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFHTTPClient {
    func getRequest(_ url: String) -> (AnyObject) {
        return Data() as (AnyObject)
    }
    
    func postRequest(_ url: String, body: String) -> (AnyObject) {
        return Data() as (AnyObject)
    }
    
    // this is synchronons way to download image via url, please use it in background
    func downloadImage(_ url: String) -> (UIImage) {
        let aUrl = URL(string: url)
        
        guard let data = try? Data(contentsOf: aUrl!) else { return UIImage() }
        
        let image = UIImage(data: data)
        return image!
    }
}
