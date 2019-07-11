//
//  FFAlbum.swift
//  FFBlueLibarySwift
//
//  Created by zhou on 2019/7/10.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

struct FFAlbum: Codable {
    var title: String
    var artist: String
    var genre: String
    var coverUrl: String
    var year: String
}

extension FFAlbum: CustomStringConvertible {
    var description: String {
        return "title: \(title)" +
        " artist: \(artist)" +
        " genre: \(genre)" +
        " coverUrl: \(coverUrl)" +
        " year: \(year)"
    }
}

typealias AlbumData = (title: String, value: String)

extension FFAlbum {
    var tableRepresentation: [AlbumData] {
        return [
            ("Artist", artist),
            ("Album", title),
            ("Genre", genre),
            ("Year", year)
        ]
    }
    
}
