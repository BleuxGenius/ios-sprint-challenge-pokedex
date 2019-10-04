//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_167 on 10/4/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
//    MARK:- properties
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
//    MARK: - Outlets
    
    
    
    @IBOutlet weak var pokePhoto: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
//    MARK: - Methods

    func updateViews() {
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        let url = URL(string: pokemon.sprites.frontDefault)!
        if let image = try? Data(contentsOf: url) {
            pokePhoto.image = UIImage(data: image)
        }
    }
}
