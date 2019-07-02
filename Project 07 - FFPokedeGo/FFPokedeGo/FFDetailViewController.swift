//
//  FFDetailViewController.swift
//  FFPokedeGo
//
//  Created by zhou on 2019/7/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFDetailViewController: UIViewController {

    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeIDLabel: UILabel!
    @IBOutlet weak var pokeInfoLabel: UILabel!
    
    var pokemon: FFPokemon! {
        didSet (newPokemon) {
            self.refreshUI()
        }
    }
    override func viewDidLoad() {
        refreshUI()
        super.viewDidLoad()
    }
    
    func refreshUI() {
        pokeIDLabel?.text = pokemon.name + (pokemon.id < 10 ? " #00\(pokemon.id)" : pokemon.id < 100 ? "#0\(pokemon.id)" : "#\(pokemon.id)")
        pokeImageView?.image = FFLibraryAPI.sharedInstance.downloadImg(pokemon.pokeImageUrl)
        pokeInfoLabel?.text = pokemon.detailInfo
        
        self.title = pokemon.name
    }
}

extension FFDetailViewController: PokemonSelectionDelegate {
    func pokemonSelected(_ newPokemon: FFPokemon) {
        pokemon = newPokemon
    }
}
