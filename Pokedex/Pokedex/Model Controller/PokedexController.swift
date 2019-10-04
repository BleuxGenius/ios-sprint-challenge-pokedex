//
//  PokedexController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_167 on 10/4/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import Foundation

//MARK: - Enums

// next create the HTTP METHODS FOR API
enum HTTPMethod: String {
    case get = "GET" // read Only
    case put = "PUT" // create data
    case post = "POST" // update or replace data
    case delete = "DELETE"  // DELETE DATA
}

// CREATE NETWORK ERRORS
enum NetworkError: Error {
    
    case encodingError
    case responseError
    case otherError(Error)
    case noData
    case BadDecode
    case noToken
    
}

class PokedexController {
    
//    MARK: - Properties
//    create properties for class
    
    var pokemon: Pokemon?
    var pokemons: [Pokemon] = []
    
    static var pokedexController = PokedexController()
    
//     create the baseURL
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
//    MARK: - Methods
    
//    create function to preform a search
    func preformSearch(with searchTerm: String, completionClosure: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
//        Request the URL
        let requestURL = baseUrl
        .appendingPathComponent(searchTerm)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
//        data Task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
//            connect to the API for search, happens after the data task has ran
            if let error = error {
                NSLog("Error retrieving searched Pokemon: \(error)")
            }
            
//            check to see if we recieved the results from search
            guard let data = data else {
                NSLog("No data returned from search.")
                completionClosure(.failure(.noData))
                return
            }
            
//            decode the data
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
                completionClosure(.success(pokemon))
                
                
            } catch {
                NSLog("Error retrieving the results to your search: \(error)")
                completionClosure(.failure(.BadDecode))
                return
            }
            
            
        }.resume()
        
    }
    
//    create fuction for creating a pokemon
    func createPokemon(name: String, sprites: Sprites, types: [TypeElement], abilities: [Ability], id: Int) {
//        the pokemon created will need the following to be a pokemon
        let pokemon = Pokemon(name: name, sprites: sprites, types: types, abilities: abilities, id: id)
//        once created append the new pokemon and save it
        pokemons.append(pokemon)
        saveToPersistentStore()
        
    }
    
//    MARK: - Persistence Methods
    
//    Create Persistence
    private var pokemonURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("pokemon.plist")
    }
    
    func loadFromPersistentStore() {
        
        let filemanager = FileManager.default
        guard let url = pokemonURL else {return}
        filemanager.fileExists(atPath: url.path)
        
        do{
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            pokemons = try decoder.decode([Pokemon].self, from: data)
        } catch {
            NSLog("Error loading data: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        guard let url = pokemonURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            NSLog("Error saving data: \(error)")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
