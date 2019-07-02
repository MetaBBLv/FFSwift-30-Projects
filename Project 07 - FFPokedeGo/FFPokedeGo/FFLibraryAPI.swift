//
//  FFLibraryAPI.swift
//  FFPokedeGo
//
//  Created by zhou on 2019/7/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFLibraryAPI: NSObject {
    static let sharedInstance = FFLibraryAPI()
    let persistencyManager = FFPersisencyManager()
    
    fileprivate override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(FFLibraryAPI.downloadImage(_:)), name: NSNotification.Name(rawValue: downloadImageNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getPokemons() -> [FFPokemon] {
        return pokemons
    }
    
    func downloadImg(_ url: String) -> (UIImage) {
    let aUrl = URL(string: url)
    let data = try? Data(contentsOf: aUrl!)
    let image = UIImage(data: data!)
    return image!
    }
    
    @objc func downloadImage(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: AnyObject]
        let pokeImageView = userInfo["pokeImageView"] as! UIImageView?
        let pokeImageUrl = userInfo["pokeImageUrl"] as! String
        
        if let imageViewUnWrapped = pokeImageView {
            imageViewUnWrapped.image = persistencyManager.getImage(URL(string: pokeImageUrl)!.lastPathComponent)
            if imageViewUnWrapped.image == nil {
                DispatchQueue.global().async {
                    let downloadedImage = self.downloadImg(pokeImageUrl as String)
                    DispatchQueue.main.async {
                        imageViewUnWrapped.image = downloadedImage
                        self.persistencyManager.saveImage(downloadedImage, filename: URL(string: pokeImageUrl)!.lastPathComponent)
                    }
                }
            }
        }
    }
}
