//
//  Pokemon.swift
//  PokeDex by Kailash
//
//  Created by Kailash Ramaswamy Krishna Kumar on 3/22/16.
//  Copyright © 2016 Kailash Ramaswamy Krishna Kumar. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name: String!
    private var _pokeDex: Int!
    private var _typeLbl: String!
    private var _weakness: String!
    private var _moves: String!
    private var _evoLbl: String!
    private var _evoPokeDex: String!
    private var _pokemonURL: String!
    
    var name: String{
        return _name
    }
    
    var pokeDex: Int{
        return _pokeDex
    }
    
    var typeLbl: String{
        if _typeLbl == nil {
            _typeLbl = ""
        }
        
        return _typeLbl
    }
    
    var evoLbl: String!{
        if _evoLbl == nil {
            _evoLbl = ""
        }
        return _evoLbl
    }
    
    var evoPoleDex: String!{
        if  _evoPokeDex == nil {
            _evoPokeDex = ""
        }
        return _evoPokeDex
    }
    
    var weakness: String!{
        if _weakness == nil {
            _weakness = ""
        }
        return _weakness
    }
    
    init(name: String, pokedexID: Int){
        _name = name
        _pokeDex = pokedexID
        _pokemonURL = "\(BASE_URL)\(POKE_URL)\(self._pokeDex)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string:_pokemonURL)!
       
        Alamofire.request(.GET, url ).responseJSON { (response) in
            let result = response.result
            
            print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weakness = weight
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    print(types.debugDescription)
                    
                    if let type = types[0]["name"] {
                        self._typeLbl = type.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count ; x++ {
                            if let name = types[x]["name"]{
                                self._typeLbl! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._typeLbl = ""
                }
                print(self._typeLbl)
            }
        }
    }
}