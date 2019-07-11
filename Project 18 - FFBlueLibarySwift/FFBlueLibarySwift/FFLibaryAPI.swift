//
//  FFLibaryAPI.swift
//  FFBlueLibarySwift
//
//  Created by zhou on 2019/7/10.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFLibaryAPI: NSObject {
    //MARK: - Singletion pattern
    static let sharedInstance = FFLibaryAPI()
    
    //MARK: Variables
    fileprivate let persistencyManager: FFPersistencyManager
    fileprivate let httpClient: FFHTTPClient
    fileprivate let isOnline: Bool
    
    fileprivate override init() {
        persistencyManager = FFPersistencyManager()
        httpClient = FFHTTPClient()
        isOnline = false
        
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: .downloadImage, name: .BLDownloadImage, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Public API
    func getAlbums() -> [FFAlbum] {
        return persistencyManager.getAlbums()
    }
    
    func addAlbum(_ album: FFAlbum, index: Int) {
        persistencyManager.addAlbum(album, index: index)
        if isOnline {
            let _ = httpClient.postRequest("/api/addAlbum", body: album.description)
        }
    }
    
    func deleteAlbum(_ index: Int) {
        persistencyManager.deleteAlbumAtIndex(index)
        if isOnline {
            let _ = httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }
    
    @objc func downloadImage(_ notification: Notification) {
        // retrieve info fro, notification
        guard let userInfo = notification.userInfo,
            let imageView = userInfo["imageView"] as? UIImageView,
            let coverUrl = userInfo["coverUrl"] as? String,
            let fileName = URL(string: coverUrl)?.lastPathComponent  else {
            return
        }
        
        // get image
        if let savedImage = persistencyManager.getImage(with: fileName) {
            imageView.image = savedImage
            return
        }
        
        DispatchQueue.global().async {
            let downloadedImage = self.httpClient.downloadImage(coverUrl as String)
            DispatchQueue.main.async {
                imageView.image = downloadedImage
                self.persistencyManager.saveImage(downloadedImage, fileName: URL(string: coverUrl)!.lastPathComponent)
            }
        }
    }
    
    func saveAlbums() {
        persistencyManager.saveAlbums()
    }
}

extension Selector {
    static let downloadImage = #selector(FFLibaryAPI.downloadImage(_:))
}
