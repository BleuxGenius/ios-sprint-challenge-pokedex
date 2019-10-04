//
//  ReallyDetailedViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_167 on 10/4/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class ReallyDetailedViewController: UIViewController {
    
//    MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
//    MARK: - Properties
    
    var pokemon: Pokemon?
    var pokedexController: PokedexController?
    
// MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    updateViews(with: pokemon)
    }
    
    func updateViews(with pokemon: Pokemon?) {
        
        guard let pokemon = pokemon else {return}
        
        pokemonIdLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("\(type.type.name)")
            types.append("\n")
        }
        
        var abilities = ""
        let abilityArray = pokemon.abilities
        
        for ability in abilityArray {
            abilities.append("\(ability.ability.name)")
            abilities.append("\n")
        }
        
        pokemonAbilitiesLabel.text = abilities
        
        let url = URL(string: pokemon.sprites.frontDefault)!
        if let image = try? Data(contentsOf: url) {
            pokemonImageView.image = UIImage(data: image)
        }
        
    }
}
