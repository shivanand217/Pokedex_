//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by shiv on 17/06/18.
//  Copyright © 2018 shiv. All rights reserved.

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var baseExp: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var abilities: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name
        typeLbl.text = ""
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        
        pokemon.downloadPokemonDetail {
            //  this will be called only after the network call will be completed and we have the data
            self.updateUI()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
        
        attackLbl.text = pokemon.attack
        weightLbl.text = pokemon.weight
        baseExp.text = pokemon.defense
        heightLbl.text = pokemon.height
        typeLbl.text = ""
        abilities.text = ""
        
        for var i in (0..<pokemon.types.count) {
            typeLbl.text = typeLbl.text! + pokemon.types[i].capitalized + " "
        }
        for var i in (0..<pokemon.abilities.count) {
            abilities.text = abilities.text! + pokemon.abilities[i].capitalized + " "
        }
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
