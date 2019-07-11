//
//  FFPersistencyManager.swift
//  FFBlueLibarySwift
//
//  Created by zhou on 2019/7/10.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFPersistencyManager: NSObject {
    fileprivate var albums = [FFAlbum]()
    fileprivate var cache: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }
    fileprivate var documents: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    private enum fileNames {
        static let Albums = "albums.json"
    }
    
    override init() {
        super.init()
        
        let savedURL = documents.appendingPathComponent(fileNames.Albums)
        var data = try? Data(contentsOf: savedURL)
        if data == nil, let bundleURL = Bundle.main.url(forResource: fileNames.Albums, withExtension: nil) {
            data = try? Data(contentsOf: bundleURL)
        }
        
        if let albumData = data,
            let decodedAlbums = try? JSONDecoder().decode([FFAlbum].self, from: albumData) {
            albums = decodedAlbums
            saveAlbums()
        }
    }
    
    func saveAlbums() {
        let url = documents.appendingPathComponent(fileNames.Albums)
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(albums) else { return }
        try? encodedData.write(to: url)
    }
    
    func getAlbums() -> [FFAlbum] {
        return albums
    }
    
    func addAlbum(_ album: FFAlbum, index: Int) {
        if albums.count >= index {
            albums.insert(album, at: index)
        } else {
            albums.append(album)
        }
    }
    
    func deleteAlbumAtIndex(_ index: Int) {
        albums.remove(at: index)
    }
    
    func saveImage(_ image: UIImage, fileName: String) {
        let url = cache.appendingPathComponent(fileName)
        guard let data = image.pngData() else { return }
        try? data.write(to: url)
    }
    
    func getImage(with FileName: String) -> UIImage? {
        let url = cache.appendingPathComponent(FileName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
    
    
}
