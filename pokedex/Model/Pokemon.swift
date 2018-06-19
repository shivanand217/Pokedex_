//  Pokemon.swift
//  pokedex
//
//  Created by apple on 15/06/18.
//  Copyright © 2018 shiv. All rights reserved.

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _types: [String]! = []
    private var _abilities: [String]! = []
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _speed: String!
    private var _baseExperience: String!
    private var _specialDefence: String!
    private var _specialAttack: String!
    private var _pokemonURL: String!
    
    // some data protections its good practice
    
    var abilities: [String] {
        if _abilities.count == 0 {
            _abilities.append("NA")
        }
        return _abilities
    }
    
    var types: [String] {
        if _types.count == 0 {
            _types.append("NA")
        }
        return _types
    }
    
    var speed: String {
        if _speed == nil {
            _speed = ""
        }
        return _speed
    }
    
    var baseExp: String {
        if _baseExperience == nil {
            _baseExperience = ""
        }
        return _baseExperience
    }
    
    var specialDefense: String {
        if _specialDefence == nil {
            _specialDefence = ""
        }
        return _specialDefence
    }
    
    var specialAttack: String {
        if _specialAttack == nil {
            _specialAttack = ""
        }
        return _specialAttack
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
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
    
    func downloadPokemonDetail(completed: @escaping DownloadCompleted) {
        
        // Request the API to get the data of the specific pokemon
        Alamofire.request(_pokemonURL, method: .get).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? Int {
                    self._weight = "\(weight)"
                }
                if let height = dict["height"] as? Int {
                    self._height = "\(height)"
                }
                if let name = dict["name"] as? String {
                    self._name = name
                }
                if let pokedexId = dict["id"] as? Int {
                    self._pokedexId = pokedexId
                }
                if let baseExp = dict["base_experience"] as? Int {
                    self._baseExperience = "\(baseExp)"
                }
                
                // retrive power metrics
                if let stat = dict["stats"] as? [Dictionary<String, AnyObject>] {
                    if let speed = stat[0]["base_stat"] as? Int {
                        self._speed = "\(speed)"
                    }
                    if let specialDefense = stat[1]["base_stat"] as? Int {
                        self._specialDefence = "\(specialDefense)"
                    }
                    if let specialAttack = stat[2]["base_stat"] as? Int {
                        self._specialAttack = "\(specialAttack)"
                    }
                    if let defence = stat[3]["base_stat"] as? Int {
                        self._defense = "\(defence)"
                    }
                    if let attack = stat[4]["base_stat"] as? Int {
                        self._attack = "\(attack)"
                    }
                }
                
                if let type1 = dict["types"] as? [Dictionary<String, AnyObject>] {
                    // get through all the types that this pokemon can take
                    for var i in (0..<type1.count) {
                        if let type2 = type1[i]["type"] as? Dictionary<String, AnyObject> {
                            if let t1 = type2["name"] as? String {
                                print(t1,terminator:" ")
                                self._types.append(t1)
                            }
                        }
                    }
                }
                
                if let able = dict["abilities"] as? [Dictionary<String, AnyObject>] {
                    // get through all the abilities
                    for var i in (0..<able.count) {
                        if let able1 = able[i]["ability"] as? Dictionary<String, AnyObject> {
                            if let a1 = able1["name"] as? String {
                                self._abilities.append(a1)
                            }
                        }
                    }
                }
                
                /**
                print(self._weight,self._height,self._name,self._baseExperience,self._attack,self._defense,self._speed)
                for var i in (0..<self._types.count) {
                    print(self._types[i],terminator:" ")
                }
                print()
                for var i in (0..<self._abilities.count) {
                    print(self._abilities[i],terminator:" ");
                }
                **/
                
            }
            
            // this tells that network call is completed now we can update our UI
            completed()
        }
    }
    
}
