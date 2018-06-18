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
    private var _types: [String]!
    private var _defense: Int!
    private var _height: Int!
    private var _weight: Int!
    private var _attack: Int!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    private var _speed: Int!
    private var _baseExperience: Int!
    private var _specialDefence: Int!
    private var _specialAttack: Int!
    private var _hp: Int!
    
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
            // print(response.result.value)
            
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
                
                // retrive power metrics
                if let stat = dict["stats"] as? [Dictionary<String, AnyObject>] {
                    if let speed = stat[0]["base_stat"] as? Int {
                        self._speed = speed
                    }
                    if let specialDefense = stat[1]["base_stat"] as? Int {
                        self._specialDefence = specialDefense
                    }
                    if let specialAttack = stat[2]["base_stat"] as? Int {
                        self._specialAttack = specialAttack
                    }
                    if let defence = stat[3]["base_stat"] as? Int {
                        self._defense = defence
                    }
                    if let attack = stat[4]["base_stat"] as? Int {
                        self._attack = attack
                    }
                    if let hp = stat[5]["base_stat"] as? Int {
                        self._hp = hp
                    }
                }
                
                if let type1 = dict["types"] as? [Dictionary<String, AnyObject>] {
                    // Looping through all the types that this pokemon can take
                    for var i in (0..<type1.count) {
                        if let type2 = type1[i]["type"] as? [Dictionary<String, AnyObject>] {
                            if let t1 = type2[1]["name"] as? String {
                                self._types.append(t1)
                            }
                        }
                    }
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
