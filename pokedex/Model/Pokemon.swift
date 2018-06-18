//
//  Pokemon.swift
//  pokedex
//
//  Created by apple on 15/06/18.
//  Copyright © 2018 shiv. All rights reserved.
//
import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: Int!
    private var _height: Int!
    private var _weight: Int!
    private var _attack: Int!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _speed: Int!
    private var _baseExperience: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: DownloadCompleted) {
        
        // request the api to get the data of the specific pokemon
        Alamofire.request(_pokemonURL, method: .get).responseJSON { (response) in
            //print(response.result.value)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? Int {
                    self._weight = weight
                }
                if let height = dict["height"] as? Int {
                    self._height = height
                }
                if let name = dict["name"] as? String {
                    self._name = name
                }
                if let pokedexId = dict["id"] as? Int {
                    self._pokedexId = pokedexId
                }
                if let baseExp = dict["base_experience"] as? Int {
                    self._baseExperience = baseExp
                }
            }
            
            if let dict1 = response.result.value as? Dictionary<String, Dictionary<String, AnyObject> > {
                if let slot = dict1["types"]!["slot"] {
                    print(slot)
                }
            }
            
            /* dict = response.result.value as! Dictionary<String, AnyObject>; do {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
            }*/
        }
    }
    
    
}
