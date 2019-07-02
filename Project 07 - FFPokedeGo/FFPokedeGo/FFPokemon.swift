//
//  FFPokemon.swift
//  FFPokedeGo
//
//  Created by zhou on 2019/7/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

enum PokeType {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case steel
    case fairv
}

class FFPokemon: NSObject {
    let name: String
    let id: Int
    let detailInfo: String
    let type: [PokeType]
    let weak: [PokeType]
    let pokeImageUrl: String
    
    init(name: String, id: Int, detailInfo: String, type: [PokeType], weak: [PokeType], pokeImageUrl: String) {
        self.name = name
        self.id = id
        self.detailInfo = detailInfo
        self.type = type
        self.weak = weak
        self.pokeImageUrl = pokeImageUrl
    }
}
