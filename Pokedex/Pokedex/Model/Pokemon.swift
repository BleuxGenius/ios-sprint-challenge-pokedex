//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_167 on 10/4/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import Foundation


//MARK: - Establishing Pokemon record with Properties

struct Results: Codable {
    let results: [Pokemon]
}

struct Pokemon: Equatable, Codable {
    
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let abilities: [Ability]
    let id: Int
}

struct Ability: Equatable, Codable {
    let ability: Species
}

struct Species: Equatable, Codable {
    let name: String
}
struct Sprites: Equatable, Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
struct TypeElement: Equatable, Codable {
    let type: Species
    
}
