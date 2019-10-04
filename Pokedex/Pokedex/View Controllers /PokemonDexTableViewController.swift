//
//  PokemonDexTableViewController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_167 on 10/4/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class PokemonDexTableViewController: UITableViewController {
//    MARK: - Properties
    
    var pokedexController = PokedexController()


//    MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        pokedexController.loadFromPersistentStore()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pokedexController.loadFromPersistentStore()
        self.tableView.reloadData()

    }
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokedexController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else
            { return UITableViewCell()}

        // Configure the cell...
//        cell.pokemon = pokedexController.pokemons[indexPath.row]

        return cell
    }

    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetailSegue" {
            guard let destinationVC = segue.destination as?
            ReallyDetailedViewController, let indexPath =
                tableView.indexPathForSelectedRow else {return}
            destinationVC.pokedexController = pokedexController
            destinationVC.pokemon = pokedexController.pokemons[indexPath.row]
        } else if segue.identifier == "SearchSegue" {
            if let destinationVC = segue.destination as?
                PokeDetailViewController {
            destinationVC.pokedexController = pokedexController
        }
        
    }


}
}
