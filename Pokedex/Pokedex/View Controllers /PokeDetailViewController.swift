//
//  PokeDetailViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_167 on 10/4/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class PokeDetailViewController: UIViewController {
    
//    MARK: - Properties
    
    var pokedexController = PokedexController()
    var pokemon: Pokemon?
    
//    MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
//    MARK: - Actions
    
    @IBAction func saveBarButtonTapped(_ sender: Any) {
        
        guard let pokemon = pokedexController.pokemon else {return}
        pokedexController.createPokemon(name: pokemon.name, sprites: pokemon.sprites, types: pokemon.types, abilities: pokemon.abilities, id: pokemon.id)
        pokedexController.saveToPersistentStore()
        navigationController?.popViewController(animated: true)
    }
    
//    MARK: - Methods
    
    func updateViews() {
        
        if let pokemon = pokedexController.pokemon {
            idLabel.text = String(pokemon.id)
            nameLabel.text = pokemon.name
            
            var types = ""
            let typeArray = pokemon.types
            
            for type in typeArray {
                types.append("\(type.type.name)")
                types.append("\n")
            }
            
            typeLabel.text = types
            
            var abilities = ""
            let abilityArray = pokemon.abilities
            
            for ability in abilityArray {
                abilities.append("\(ability.ability.name)")
                abilities.append("\n")
            }
            
            abilitiesLabel.text = abilities
            
            let url = URL(string: pokemon.sprites.frontDefault)!
            if let image = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: image)
            }
        } else {
            
            let alert = UIAlertController(title: "Oops! we could not find that pokemon!", message: "Please Try Again", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true)

        }
    }
    
    
    
// MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    



}

// MARK: - Extentions

extension PokeDetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    guard let searchTerm = searchBar.text else
        
    { return }
        
        pokedexController.preformSearch(with: searchTerm) { (error) in
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
}
