//
//  Pokemon.swift
//  PokeDex by Kailash
//
//  Created by Kailash Ramaswamy Krishna Kumar on 3/22/16.
//  Copyright © 2016 Kailash Ramaswamy Krishna Kumar. All rights reserved.
//

import Foundation

class Pokemon{
    private var _name: String!
    private var _pokeDex: Int!
    
    var name: String{
        return _name
    }
    
    var pokeDex: Int{
        return _pokeDex
    }
    
    init(name: String, pokedexID: Int){
        _name = name
        _pokeDex = pokedexID
    }
}