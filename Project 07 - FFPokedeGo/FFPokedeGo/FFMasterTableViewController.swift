//
//  FFMasterTableViewController.swift
//  FFPokedeGo
//
//  Created by zhou on 2019/7/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PokemonSelectionDelegate: class {
    func pokemonSelected(_ newPokemon: FFPokemon)
}

class FFMasterTableViewController: UITableViewController {

    var pokemons = FFLibraryAPI.sharedInstance.getPokemons()
    var filteredPokemons = [FFPokemon]()
    weak var delegate: PokemonSelectionDelegate?
    
    fileprivate let disposeBag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        filteredPokemons = pokemons
    }
    
    fileprivate func setupUI() {
        self.title = "精灵列表"
        definesPresentationContext = true
        
        searchBar.rx.text.throttle(0.5, scheduler: MainScheduler.instance).subscribe(
            onNext: { [unowned self] query in
                if query?.count == 0 {
                    self.filteredPokemons = self.pokemons
                } else {
                    self.filteredPokemons = self.pokemons.filter{ $0.name.hasPrefix(query!)}
                }
                self.tableView.reloadData()
        })
            .disposed(by: disposeBag)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = self.filteredPokemons[(indexPath as NSIndexPath).row]
        delegate?.pokemonSelected(pokemon)
        
        if let detailViewController = self.delegate as? FFDetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredPokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FFMasterTableViewCell
        let pokemon = filteredPokemons[(indexPath as NSIndexPath).row]
        cell.awakeFromNib(pokemon.id, name: pokemon.name, pokeImageUrl: pokemon.pokeImageUrl)
        return cell
    }
}
